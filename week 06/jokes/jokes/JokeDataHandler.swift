//
//  JokeDataHandler.swift
//  jokes
//
//  Created by Aileen Pierce on 2/17/21.
//

import Foundation

class JokeDataHandler {
    var jokeData = JokeData()
    //property with a closure as its value
    //closure takes an array of Joke as its parameter and Void as its return type
    var onDataUpdate: ((_ data: [Joke]) -> Void)?
    
    func loadjson(){
        //based on API documentation
        //https://rapidapi.com/KegenGuyll/api/dad-jokes?endpoint=apiendpoint_d9018ef4-ad90-4037-b8fa-4ff5a766e234
        let headers = [
            "x-rapidapi-key": "4ed30fc463mshe74ccdc811abd17p194096jsn5a51929bf13d",
            "x-rapidapi-host": "dad-jokes.p.rapidapi.com"
        ]
        
        let urlPath = "https://dad-jokes.p.rapidapi.com/joke/type/programming"
        
        guard let url = URL(string: urlPath)
            else {
                print("url error")
                return
            }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            print(statusCode)
            guard statusCode == 200
                else {
                    print("file download error")
                    return
                }
            //download successful
            print("download complete")
            //parse json asynchronously
            DispatchQueue.main.async {self.parsejson(data!)}
        })
        //must call resume to run session
        session.resume()
    }
    
    func parsejson(_ data: Data){
        do
        {
            let apiData = try JSONDecoder().decode(JokeData.self, from: data)
            for joke in apiData.body
            {
                jokeData.body.append(joke)
                print(joke)
            }
            print(jokeData.body.count)
        }
        catch let jsonErr
        {
            print("json error")
            print(jsonErr.localizedDescription)
            return
        }
        print("parsejson done")
        //passing the results to the onDataUpdate closure
        onDataUpdate?(jokeData.body)
    }

    func getJokes() -> [Joke] {
        return jokeData.body
    }

}
