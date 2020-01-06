//
//  GameResponse.swift
//  DiceRoll
//
//  Created by Alexandre ALLAIN on 06/01/2020.
//  Copyright © 2020 Alexandre ALLAIN. All rights reserved.
//

import Foundation

class GameResponse: Decodable {
    var status: Int
    var data: [Game]
    
    init(status: Int = 200, data: [Game] = []) {
        self.status = status
        self.data = data
    }
    
    public func addData(data: Game) {
        self.data.append(data)
    }
}
