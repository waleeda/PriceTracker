//
//  ViewController.swift
//  Price Tracker
//
//  Created by Waleed Azhar on 2017-07-26.
//  Copyright © 2017 Waleed Azhar. All rights reserved.
//

import UIKit
import WebKit

struct ProductTrackingRecord {
    let productName: String
    let prices: [ProductPriceRecord]
}

struct ProductPriceRecord {
    let productPageUrl: String
    let sellerName: String
    let loctionOfPriceTag: CGPoint
    let frameWhenLocationRecorded: CGRect
}

class ViewController: UIViewController,WKNavigationDelegate,UIGestureRecognizerDelegate {

    var webView = WKWebView()
    var highlight = UIView()
    var tapGesture = UITapGestureRecognizer(target: self, action: #selector(webViewTapped(tap:)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       //  webView.navigationDelegate = self;
        view.addSubview(webView)
        constraintToEdges(subview: webView)

        tapGesture = UITapGestureRecognizer(target: self, action: #selector(webViewTapped(tap:)))
        webView.scrollView.addGestureRecognizer(tapGesture)
        webView.navigationDelegate = self
        
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        highlight.layer.borderWidth = 2
        highlight.layer.borderColor = UIColor.red.cgColor
        webView.scrollView.addSubview(highlight)

        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.webView.load(URLRequest(url:URL(string: "http://www.bestbuy.ca/en-ca/product/apple-apple-watch-series-2-42mm-space-grey-aluminum-case-with-black-sport-band-mp062cl-a/10487548.aspx?")!))

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func constraintToEdges(subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.widthAnchor.constraint(equalTo: view.widthAnchor),
            subview.heightAnchor.constraint(equalTo: view.heightAnchor),
            subview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subview.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
    }
    
    var lastPoint: CGPoint?

    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("DFdffddfasge")
        completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("DFdffddfasge")
        print(error )
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        print(webView.estimatedProgress)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    


    @objc func webViewTapped(tap: UITapGestureRecognizer) {
        
        let point:CGPoint
        point = tap.location(in: webView.scrollView) // CGPoint(x: 61.3333282470703, y: 525.0)
        print(point)
        let javascript = "var hh = document.elementFromPoint(\(point.x), \(point.y - webView.scrollView.contentOffset.y + webView.scrollView.contentInset.top)).innerHTML; var rect = document.elementFromPoint(\(point.x), \(point.y - webView.scrollView.contentOffset.y + webView.scrollView.contentInset.top)).getBoundingClientRect(); (rect.top + window.scrollY).toString() +\"!@#\" + rect.left.toString() +\"!@#\" + rect.width.toString() +\"!@#\" + rect.height.toString() +\"!@#\" + hh ; "
        
        webView.evaluateJavaScript(javascript) { [weak self] (value, error) in
            if let dimensions = value as? String {
                var components = dimensions.components(separatedBy: "!@#")
                var com2 = components[0...3].flatMap({ (com) -> CGFloat? in
                    return CGFloat.init(Double.init(com)!)
                })
                print(com2)
                let rect = CGRect(x: com2[1], y: com2[0], width: com2[2], height: com2[3])
                self?.highlight.frame = rect
                self?.lastPoint = CGPoint(x: com2[1], y: com2[0])
                
                var track = ModelData.shared.tracks.popLast()!

                var product = track.products.popLast()!
                product.price = components.last!
                let urlParts = self?.webView.url?.absoluteString.components(separatedBy: "/") ?? []
                product.name = urlParts[2]
                track.products.append(product)
                ModelData.shared.tracks.append(track)
            }
        }
        
    }
    
    func readPrice() {
        let point:CGPoint = lastPoint!
        print(lastPoint)
        let javascript = "var hh = document.elementFromPoint(\(point.x), \(point.y)).innerHTML; "
        webView.evaluateJavaScript(javascript) { [weak self] (value, error) in
            print(value)

        }
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true;
    }
    
}

