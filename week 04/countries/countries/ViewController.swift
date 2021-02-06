//
//  ViewController.swift
//  countries
//
//  Created by Aileen Pierce
//

import UIKit

class ViewController: UITableViewController {
    
    var continentList = [String]()
    var continentsData = ContinentsDataLoader()
    let dataFile = "continents2"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        continentsData.loadData(filename: dataFile)
        continentList=continentsData.getContinents()
        
        //enables large titles
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    //Number of rows in the section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return continentList.count
    }
    
    // Displays table view cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //configure the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryIdentifier", for: indexPath)
        cell.textLabel?.text = continentList[indexPath.row]
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "countrysegue" {
            if let detailVC = segue.destination as? DetailViewController {
                if let indexPath = tableView.indexPath(for: (sender as? UITableViewCell)!) {
                    //sets the data for the destination controller
                    detailVC.title = continentList[indexPath.row]
                    detailVC.continentsData = continentsData
                    detailVC.selectedContinent = indexPath.row
                }
            }
        } //for detail disclosure
        else if segue.identifier == "continentsegue"{
            let infoVC = segue.destination as! ContinentInfoTableViewController
            let editingCell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: editingCell)
            infoVC.name = continentList[indexPath!.row]
            let countryList = continentsData.getCountries(index: (indexPath?.row)!)
            infoVC.number = String(countryList.count)
        }
    }

}

