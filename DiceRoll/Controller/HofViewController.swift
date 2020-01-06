//
//  HofViewController.swift
//  DiceRoll
//
//  Created by Alexandre ALLAIN on 06/01/2020.
//  Copyright © 2020 Alexandre ALLAIN. All rights reserved.
//

import UIKit

class HofViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        GameService.getGames() { games in
            print(games)
        }
        
    }


}
