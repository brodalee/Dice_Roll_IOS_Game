//
//  GameViewController.swift
//  DiceRoll
//
//  Created by Alexandre ALLAIN on 02/01/2020.
//  Copyright © 2020 Alexandre ALLAIN. All rights reserved.
//

import UIKit

class GameViewController: ViewController {
    
    var points: Int?
    var firstPlayer: Player?
    var secondPlayer: Player?
    var currentPlayer: Player?
    var currentCombo: Int = 0
    
    @IBOutlet weak var turnPlayerName: UILabel!
    @IBOutlet weak var firstDice: UIImageView!
    @IBOutlet weak var secondDice: UIImageView!
    
    @IBOutlet weak var uiCurrentCombo: UILabel!
    @IBOutlet weak var uiFirsPlayerName: UILabel!
    @IBOutlet weak var uiSecondPlayerName: UILabel!
    @IBOutlet weak var uiScoreToRun: UILabel!
    @IBOutlet weak var uiSecondPlayerScore: UILabel!
    @IBOutlet weak var uiFirstPlayerScore: UILabel!
    @IBOutlet weak var uiFirstPlayerRolls: UILabel!
    @IBOutlet weak var uiSecondPlayerRolls: UILabel!
    
    public func initialize(first: String, second: String, point: Int) {
        self.firstPlayer = Player(name: first)
        self.secondPlayer = Player(name: second)
        self.points = point
        self.currentPlayer = self.firstPlayer
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.uiFirsPlayerName.text = self.firstPlayer!.name!
        self.uiSecondPlayerName.text = self.secondPlayer!.name!
        self.uiScoreToRun.text = "Score à atteindre : " + String(self.points!)
        self.updateUI()
    }

    @IBAction func rollDices(_ sender: UIButton, forEvent event: UIEvent) {
        let firstDice = Int.random(in: 1...6)
        let secondDice = Int.random(in: 1...6)
        
        self.firstDice.image = UIImage(systemName: "0" + String(firstDice) + ".circle.fill")
        self.secondDice.image = UIImage(systemName: "0" + String(secondDice) + ".circle.fill")
        self.currentCombo += (firstDice + secondDice)
        self.currentPlayer!.turnNumber += 1
        
        if firstDice == secondDice {
            self.currentCombo = 0
            if self.currentPlayer!.name != self.firstPlayer!.name {
                self.firstPlayer!.currentScore = 0
            } else {
                self.secondPlayer!.currentScore = 0
            }
            self.changeTurn()
        }
        
        if firstDice == 1 || secondDice == 1 {
            self.currentCombo = 0
            self.changeTurn()
        }
        
        self.updateUI()
    }
    
    private func updateUI() {
        self.uiFirstPlayerRolls.text = String(self.firstPlayer!.turnNumber)
        self.uiSecondPlayerRolls.text = String(self.secondPlayer!.turnNumber)
        self.uiFirstPlayerScore.text = String(self.firstPlayer!.currentScore)
        self.uiSecondPlayerScore.text = String(self.secondPlayer!.currentScore)
        self.uiCurrentCombo.text = "Combo actuel : " + String(self.currentCombo)
        self.turnPlayerName.text = self.currentPlayer!.name! + " c'est ton tour !"
    }
    
    private func changeTurn() {
        if self.currentPlayer!.name == self.firstPlayer!.name {
            self.currentPlayer = self.secondPlayer
        } else {
            self.currentPlayer = self.firstPlayer
        }
        self.updateUI()
    }
    
    @IBAction func saveCurrentCombo(_ sender: UIButton, forEvent event: UIEvent) {
        self.currentPlayer!.currentScore += self.currentCombo
        self.currentCombo = 0
        if self.currentPlayer!.currentScore >= self.points! {
            self.showWinner()
        } else {
            self.changeTurn()
        }
    }
    
    private func showWinner() {
        let this = self
        let GGAction = UIAlertAction(title: "OK", style: .default) { (action) in this.dismiss(animated: true, completion: nil)
            let game = Game()
            game.forscore = this.points!
            game.score = this.currentPlayer!.currentScore
            game.turnnumber = this.currentPlayer!.turnNumber
            game.winner = this.currentPlayer!.name!
            GameService.addNewGame(game: game)
        }
        let winner = UIAlertController(title: "Partie terminé !", message: "Bravo " + self.currentPlayer!.name! + " tu as gagné la partie", preferredStyle: .alert)
        winner.addAction(GGAction)
        self.present(winner, animated: true)
    }
}
