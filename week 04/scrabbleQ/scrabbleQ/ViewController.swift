//
//  ViewController.swift
//  scrabbleQ
//
//  Created by Aileen Pierce
//

import UIKit

class ViewController: UITableViewController {
    
    var words = [String]()
    var data = DataLoader()
    let wordFile = "qwordswithoutu1"
    var searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        //load data
        data.loadData(filename: wordFile)
        //get words
        words = data.getWords()
        
        //search results
        let resultsController = SearchResultsController() //create an instance of our SearchResultsController class
        resultsController.allwords = words //set the allwords property to our words array
        searchController = UISearchController(searchResultsController: resultsController) //initialize our search controller with the resultsController when it has search results to display
        
        //search bar configuration
        searchController.searchBar.placeholder = "Enter a search term" //place holder text
        searchController.searchBar.sizeToFit() //sets appropriate size for the search bar
        tableView.tableHeaderView=searchController.searchBar //install the search bar as the table header
        searchController.searchResultsUpdater = resultsController //sets the instance to update search results
    }

    //Required methods for UITableViewDataSource
    // Customize the number of rows in the section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        words.count
    }
    
    // Displays table view cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //dequeues an existing cell if one is available, or creates a new one and adds it to the table
        let cell = tableView.dequeueReusableCell(withIdentifier: "scrabbleIdentifier", for: indexPath)
        cell.textLabel?.text = words[indexPath.row]
        return cell
    }
    
    //UITableViewDelegate method that is called when a row is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Row selected", message: "You selected \(words[indexPath.row])", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true) //deselects the row that had been chosen
    }

}

