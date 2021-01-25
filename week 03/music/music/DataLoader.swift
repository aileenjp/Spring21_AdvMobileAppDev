//
//  DataLoader.swift
//  music
//
//  Created by Aileen Pierce
//

import Foundation

class DataLoader {
    var allData = [ArtistAlbums]()
    
    func loadData(filename: String){
        if let pathURL = Bundle.main.url(forResource: filename, withExtension:  "plist") {
            //initialize a property list decoder object
            let plistdecoder = PropertyListDecoder()
            do {
                let data = try Data(contentsOf: pathURL)
                //decodes the property list
                allData = try plistdecoder.decode([ArtistAlbums].self, from: data)
            } catch {
                //handle error
                print("Cannot load data")
            }
        }
    }
    
    func getArtists() -> [String]{
        var artists = [String]()
        for artist in allData {
            artists.append(artist.name)
        }
        return artists
    }
    
    func getAlbums(index: Int) -> [String] {
        return allData[index].albums
    }
}
