//
//  DetailViewController.swift
//  countries
//
//  Created by Aileen Pierce
//

import UIKit

class DetailViewController: UITableViewController {
    var continentsData = ContinentsDataLoader()
    var selectedContinent = 0
    var countryList = [String]()

    override func viewWillAppear(_ animated: Bool) {
        countryList = continentsData.getCountries(index: selectedContinent)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return countryList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryIdentifier", for: indexPath)

        cell.textLabel?.text = countryList[indexPath.row]

        return cell
    }


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }



    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Delete the country from the array
            countryList.remove(at: indexPath.row)
            // Delete the row from the table
            tableView.deleteRows(at: [indexPath], with: .fade)
            //Delete from the data model instance
            continentsData.deleteCountry(index: selectedContinent, countryIndex: indexPath.row)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let fromRow = fromIndexPath.row //row being moved from
        let toRow = to.row //row being moved to
        let moveCountry = countryList[fromRow] //country being moved
        //swap positions in array
        countryList.swapAt(fromRow, toRow)
        //move in data model instance
        continentsData.deleteCountry(index: selectedContinent, countryIndex: fromRow)
        continentsData.addCountry(index: selectedContinent, newCountry: moveCountry, newIndex: toRow)
    }



    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }


    @IBAction func unwindSegue (_ segue:UIStoryboardSegue){
        if segue.identifier=="doneSegue"{
            if let source = segue.source as? AddCountryViewController {
                //only add a country if there is text in the textfield
                if source.addedCountry.isEmpty == false{
                    //add country to our data model instance
                    continentsData.addCountry(index: selectedContinent, newCountry: source.addedCountry, newIndex: countryList.count)
                    //add country to the array
                    countryList.append(source.addedCountry)
                    tableView.reloadData()
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
