//
//  GameService.swift
//  DiceRoll
//
//  Created by Alexandre ALLAIN on 06/01/2020.
//  Copyright © 2020 Alexandre ALLAIN. All rights reserved.
//

import Foundation

class GameService {
    
    private static let gameURL = URL(string: "http://localhost:8798/?scores=all")!
    
    static func getGames(callback: @escaping ([Game]) -> Void ) {
        var request = URLRequest(url: gameURL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: gameURL) { (data, response, error) in
            if error != nil { return }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200, let data = data, let dataString = String(data: data, encoding: .utf8) {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: dataString.data(using: .utf8)!, options: []) as? [String: Any]
                        if let realData = jsonResponse as? [String: Any] {
                            let gameResponse = GameResponse(status: realData["status"]! as! Int)
                            print(gameResponse.status)
                            let games = realData["data"]! as? Array<AnyObject>
                            var responseGame: [Game] = []
                            for game in games! {
                                let newGame = Game()
                                newGame.forscore = Int(game["forscore"]! as! String) as! Int
                                newGame.score = Int(game["score"]! as! String) as! Int
                                newGame.winner = game["winner"]! as! String
                                newGame.turnnumber = Int(game["turnnumber"]! as! String) as! Int
                                newGame.id =  Int(game["id"]! as! String) as! Int
                                responseGame.append(newGame)
                            }
                            callback(responseGame)
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }
        }
        task.resume()
    }
}
