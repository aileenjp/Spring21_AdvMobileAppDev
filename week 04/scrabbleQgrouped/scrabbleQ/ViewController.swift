//
//  ViewController.swift
//  scrabbleQ
//
//  Created by Aileen Pierce
//

import UIKit

class ViewController: UITableViewController {
    
    var words = [GroupedWords]()
    var letters = [String]()
    var data = DataLoader()
    let wordFile = "qwordswithoutu3"
    var searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        //load data
        data.loadData(filename: wordFile)
        //get words
        words = data.getWords()
        // get letters
        letters = data.getLetters()
        
        //search results
        let resultsController = SearchResultsController() //create an instance of our SearchResultsController class
        resultsController.allwords = words
        searchController = UISearchController(searchResultsController: resultsController) //create a search controller and initialize with our SearchResultsController instance
        
        //search bar configuration
        searchController.searchBar.placeholder = "Enter a search term" //place holder text
        //searchController.searchBar.sizeToFit() //sets appropriate size for the search bar
        tableView.tableHeaderView=searchController.searchBar //install the search bar as the table header
        searchController.searchResultsUpdater = resultsController //sets the instance to update search results
    }

    //Required methods for UITableViewDataSource
    // Customize the number of rows in the section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        words[section].words.count
    }
    
    // Displays table view cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //dequeues an existing cell if one is available, or creates a new one and adds it to the table
        let section = indexPath.section
        let wordsSection = words[section].words
        //configure the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "scrabbleIdentifier", for: indexPath)
        cell.textLabel?.text = wordsSection[indexPath.row]
        return cell
    }
    
    //UITableViewDelegate method that is called when a row is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let wordsSection = words[section].words
        let alert = UIAlertController(title: "Row selected", message: "You selected \(wordsSection[indexPath.row])", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true) //deselects the row that had been chosen
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerview = view as! UITableViewHeaderFooterView
        headerview.textLabel?.font = UIFont(name: "Helvetica", size: 20)
        headerview.textLabel?.textAlignment = .center
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return letters.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //tableView.headerView(forSection: section)?.textLabel?.textAlignment = NSTextAlignment.center
        return letters[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return letters
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerview = UITableViewHeaderFooterView()
        var myView:UIImageView
        if section == 0 {
            myView = UIImageView(frame: CGRect(x: 10, y: 8, width: 40, height: 40))
        } else {
            myView = UIImageView(frame: CGRect(x: 10, y: -10, width: 40, height: 40))
        }
        let myImage = UIImage(named: "scrabbletile90")
        myView.image = myImage
        headerview.addSubview(myView)
        return headerview
    }
}

