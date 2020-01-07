//
//  HofViewController.swift
//  DiceRoll
//
//  Created by Alexandre ALLAIN on 06/01/2020.
//  Copyright © 2020 Alexandre ALLAIN. All rights reserved.
//

import UIKit

class HofViewController: ViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var games: [Game] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        GameService.getGames() { games in
            self.games = games
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

}

extension HofViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath)
        let game = self.games[indexPath.row]
        cell.textLabel?.text = game.winner
        cell.detailTextLabel?.text = "Score : " + String(game.score) + " | But : " + String(game.forscore) + " | En " + String(game.turnnumber) + " tours"
        return cell
    }
}
