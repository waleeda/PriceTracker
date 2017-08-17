//
//  NewProductTableViewController.swift
//  Price Tracker
//
//  Created by Waleed Azhar on 8/17/17.
//  Copyright © 2017 Waleed Azhar. All rights reserved.
//

import UIKit

class NewProductTableViewController: UITableViewController {

    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var name: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func donePressed(_ sender: Any) {

    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let u = url.text, let n = name.text {
            var track = PriceTrack(products: [], name: n)
            track.products.append(Product(name: n, url: u, price: ""))
            ModelData.shared.tracks.append(track)
        }
        else {
            var track = PriceTrack(products: [], name: "Test")
            track.products.append(Product(name: "Test", url: "", price: ""))
            ModelData.shared.tracks.append(track)
        }
    }
    

}
