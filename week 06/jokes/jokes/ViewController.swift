//
//  ViewController.swift
//  jokes
//
//  Created by Aileen Pierce on 2/17/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var jokeDataHandler = JokeDataHandler()
    var jokes = [Joke]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //assign the closure with the method we want called to the onDataUpdate closure
        jokeDataHandler.onDataUpdate = {[weak self] (data:[Joke]) in self?.render()}
        jokeDataHandler.loadjson()
        print("Number of jokes \(jokes.count)")
        // ues test data
        // loadtestdata()
    }

    func loadtestdata() {
        //test data
        let joke1 = Joke(setup: "What's the best thing about a Boolean?", punchline: "Even if you're wrong, you're only off by a bit.")
        let joke2 = Joke(setup: "What's the object-oriented way to become wealthy?", punchline: "Inheritance")
        let joke3 = Joke(setup: "If you put a million monkeys at a million keyboards, one of them will eventually write a Java program?", punchline: "the rest of them will write Perl")
        jokes.append(joke1)
        jokes.append(joke2)
        jokes.append(joke3)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        jokes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jokeIdentifier", for: indexPath)
        let joke = jokes[indexPath.row]
        cell.textLabel!.text = joke.setup
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: jokes[indexPath.row].setup, message: jokes[indexPath.row].punchline, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Haha", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true) //deselects the row that had been choosen
    }

    func render() {
        jokes = jokeDataHandler.getJokes()
        tableView.reloadData()
    }
}

