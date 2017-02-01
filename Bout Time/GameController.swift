//
//  ViewController.swift
//  Bout Time
//
//  Created by Muhammad Moaz on 1/27/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var currentRound: [Event] = []
    fileprivate let game = Game()
    private var roundNumber: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.isScrollEnabled = false
        configureRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureRound() {
        self.currentRound = game.rounds[roundNumber]
        self.tableView.reloadData()
    }
}

extension GameController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentRound.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameCell.identifier, for: indexPath) as! GameCell
        let event = self.currentRound[indexPath.row]
        cell.event = event
        return cell
    }
}
