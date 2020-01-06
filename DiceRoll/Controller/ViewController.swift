//
//  ViewController.swift
//  DiceRoll
//
//  Created by Alexandre ALLAIN on 02/01/2020.
//  Copyright © 2020 Alexandre ALLAIN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstPlayerName: UITextField!
    @IBOutlet weak var secondPlayeName: UITextField!
    @IBOutlet weak var maxRadioBtn: BrodaleeRadioButton!
    @IBOutlet weak var middleRadioBtn: BrodaleeRadioButton!
    @IBOutlet weak var lowRadioBtn: BrodaleeRadioButton!
    
    var maxPoint: Int?
    
    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in}
    
    @IBAction func startGame(_ sender: UIButton, forEvent event: UIEvent) {
        let first = firstPlayerName.text!
        let second = secondPlayeName.text!
        if (first.trimmingCharacters(in: .whitespacesAndNewlines) as String) != "" {
            if (second.trimmingCharacters(in: .whitespacesAndNewlines) as String) != "" {
                if self.maxPoint != nil {
                    let storyBoard = UIStoryboard(name: "Game", bundle: nil)
                    let gameViewController = storyBoard.instantiateViewController(withIdentifier: "Game") as! GameViewController
                    gameViewController.initialize(
                        first: self.firstPlayerName.text!,
                        second: self.secondPlayeName.text!,
                        point: self.maxPoint! )
                    self.present(gameViewController, animated: true, completion: nil)
                } else {
                    self.showErrorForm()
                }
            } else {
                self.showErrorForm()
            }
        } else {
            self.showErrorForm()
        }
    }
    
    private func showErrorForm() {
        let error = UIAlertController(title: "Champs oublié", message: "Veuillez remplir tous les champs", preferredStyle: .alert)
        error.addAction(self.OKAction)
        self.present(error, animated: true)
    }
    
    @IBAction func lowRadioBtn(_ sender: BrodaleeRadioButton, forEvent event: UIEvent) {
        sender.outerCircleColor = UIColor.red
        self.maxPoint = 20
        middleRadioBtn.outerCircleColor = UIColor.green
        maxRadioBtn.outerCircleColor = UIColor.green
    }
    
    @IBAction func middleRadioBtn(_ sender: BrodaleeRadioButton, forEvent event: UIEvent) {
        sender.outerCircleColor = UIColor.red
        self.maxPoint = 30
        maxRadioBtn.outerCircleColor = UIColor.green
        lowRadioBtn.outerCircleColor = UIColor.green
    }
    
    @IBAction func maxRadioBtn(_ sender: BrodaleeRadioButton, forEvent event: UIEvent) {
        sender.outerCircleColor = UIColor.red
        self.maxPoint = 40
        middleRadioBtn.outerCircleColor = UIColor.green
        lowRadioBtn.outerCircleColor = UIColor.green
    }
    
    @IBAction func seeHof(_ sender: UIButton, forEvent event: UIEvent) {
        let storyBoard = UIStoryboard(name: "Hof", bundle: nil)
        let hofViewController = storyBoard.instantiateViewController(withIdentifier: "Hof") as! HofViewController
        self.present(hofViewController, animated: true, completion: nil)
    }
}
