//
//  GroupedWords.swift
//  scrabbleQ
//
//  Created by Aileen Pierce
//

import Foundation

struct GroupedWords: Decodable {
    let letter : String
    let words : [String]
}
