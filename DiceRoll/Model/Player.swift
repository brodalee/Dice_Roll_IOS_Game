//
//  Player.swift
//  DiceRoll
//
//  Created by Alexandre ALLAIN on 03/01/2020.
//  Copyright © 2020 Alexandre ALLAIN. All rights reserved.
//

import Foundation

class Game {
    var turnnumber: Int = 0
    var forscore: Int = 0
    var winner: Player?
    var score: Int = 0
}

class Player {
    var name: String?
    var currentScore: Int = 0
    var turnNumber: Int = 0
    
    init(name: String) {
        self.name = name
    }
}
