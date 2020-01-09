//
//  GameService.swift
//  DiceRoll
//
//  Created by Alexandre ALLAIN on 06/01/2020.
//  Copyright © 2020 Alexandre ALLAIN. All rights reserved.
//

import Foundation

class GameService {
    
    private struct Keys {
        static let baseUrl = "http://brodaleee.alwaysdata.net/?scores="
    }
    
    private static let gameURL = URL(string: Keys.baseUrl + "all")!
    
    static func getGames(callback: @escaping ([Game]) -> Void ) {
        var request = URLRequest(url: gameURL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil { return }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200, let data = data, let dataString = String(data: data, encoding: .utf8) {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: dataString.data(using: .utf8)!, options: []) as? [String: Any]
                        if let realData = jsonResponse as? [String: Any] {
                            let gameResponse = GameResponse(status: realData["status"]! as! Int)
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
                            DispatchQueue.main.async {
                               callback(responseGame)
                            }
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }
        }
        task.resume()
    }
    
    static func deleteGame(id: Int, callback: @escaping () -> Void ) {
        let url = URL(string: Keys.baseUrl + "delete&id=" + String(id))!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil { return }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    DispatchQueue.main.async {
                       callback()
                    }
                }
            }
        }
        
        task.resume()
    }
    
    static func addNewGame(game: Game) {
        let url = URL(string: Keys.baseUrl + "add")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        var body = "winner=" + String(game.winner!)
        body += "&score=" + String(game.score)
        body += "&turnnumber=" + String(game.turnnumber)
        body += "&forscore=" + String(game.forscore)
        request.httpBody = body.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil { return }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200, let data = data, let dataString = String(data: data, encoding: .utf8) {
                }
            }
        }
        task.resume()
    }
}
