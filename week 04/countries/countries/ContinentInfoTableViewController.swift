//
//  ContinentInfoTableViewController.swift
//  countries
//
//  Created by Aileen Pierce
//

import UIKit

class ContinentInfoTableViewController: UITableViewController {
    
    var name = String()
    var number = String()

    @IBOutlet weak var continentName: UILabel!
    @IBOutlet weak var countryNumber: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        continentName.text=name
        countryNumber.text=number
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

}

