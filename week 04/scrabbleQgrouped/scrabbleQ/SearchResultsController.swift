//
//  SearchResultsController.swift
//  scrabbleQ
//
//  Created by Aileen Pierce
//

import UIKit

class SearchResultsController: UITableViewController, UISearchResultsUpdating {
    var allwords = [GroupedWords]()
    var filteredWords = [String]()

    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text //search string
        filteredWords.removeAll(keepingCapacity: true) //removes all elements        if searchString?.isEmpty == false {
        if searchString?.isEmpty == false {
            //closure that will be called for each word to see if it matches the search string
            let filter: (String) -> Bool = { name in
                //look for the search string as a substring of the word
                let range = name.range(of: searchString!, options: .caseInsensitive)
                return range != nil //returns true if the value matches and false if there’s no match
            }
            //iterate over all the letters
            for item in allwords {
                let wordsForLetter = item.words //array of words for each letter
                let matches = wordsForLetter.filter(filter) //filter using the closure
                filteredWords.append(contentsOf: matches) //add words that match
            }
        }
        tableView.reloadData() //reload table data with search results
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //register our table cell identifier
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "scrabbleIdentifier")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredWords.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scrabbleIdentifier", for: indexPath)
        cell.textLabel?.text = filteredWords[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Row selected", message: "You selected \(filteredWords[indexPath.row])", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true) //deselects the row that had been choosen
    }

}
