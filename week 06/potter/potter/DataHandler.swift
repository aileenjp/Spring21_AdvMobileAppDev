//
//  DataHandler.swift
//  potter
//
//  Created by Aileen Pierce
//

import Foundation

class DataHandler{
    var allData = [Character]()
    
    func loadData(fileName: String){
        if let pathURL = Bundle.main.url(forResource: fileName, withExtension: "plist"){
            //creates a property list decoder object
            let plistdecoder = PropertyListDecoder()
            do {
                let data = try Data(contentsOf: pathURL)
                //decodes the property list
                allData = try plistdecoder.decode([Character].self, from: data)
            } catch {
                // handle error
                print(error)
            }
        }
    }
    
    func getCharacters() -> [String]{
        var characters = [String]()
        for character in allData{
            characters.append(character.name)
        }
        return characters
    }
    
    func getURL(index:Int) -> String {
        return allData[index].url
    }
}
