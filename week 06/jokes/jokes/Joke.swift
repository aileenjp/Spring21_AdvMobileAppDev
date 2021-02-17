//
//  Joke.swift
//  jokes
//
//  Created by Aileen Pierce on 2/17/21.
//

import Foundation

struct Joke: Decodable {
    let setup: String
    let punchline: String
}

struct JokeData: Decodable {
    var body = [Joke]()
}
