//
//  DataLoader.swift
//  scrabbleQ
//
//  Created by Aileen Pierce
//

import Foundation

class DataLoader{
    var qNoUWords = [String]()

    func loadData(filename: String){
        // URL for our plist
        if let pathURL = Bundle.main.url(forResource: filename, withExtension:  "plist") {
            //initialize a property list decoder object
            let plistdecoder = PropertyListDecoder()
            do {
                let data = try Data(contentsOf: pathURL)
                //decodes the property list
                qNoUWords = try plistdecoder.decode([String].self, from: data)
            } catch {
                //handle error
                print("Cannot load data")
            }
        }
    }

    func getWords()->[String]{
        return qNoUWords
    }

}

