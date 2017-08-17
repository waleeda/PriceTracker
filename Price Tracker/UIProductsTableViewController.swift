//
//  UIProductsTableViewController.swift
//  Price Tracker
//
//  Created by Waleed Azhar on 8/17/17.
//  Copyright © 2017 Waleed Azhar. All rights reserved.
//

import UIKit

class UIProductsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return ModelData.shared.tracks.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ModelData.shared.tracks[section].products.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ModelData.shared.tracks[section].name
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "product", for: indexPath)
        let product = ModelData.shared.tracks[indexPath.section].products[indexPath.row]
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = product.price

        return cell
    }
    
    
    @objc func addAnotherTapped(button: UIButton) {
        print(button.tag)
        
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var addAnother = UIButton.init(type: .roundedRect)
        addAnother.setTitle("Add Another Price \(section)", for: UIControlState.normal)
        addAnother.tag = section
        addAnother.addTarget(self, action: #selector(addAnotherTapped(button:)), for: UIControlEvents.touchUpInside)
        return addAnother
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 54
    }


}
