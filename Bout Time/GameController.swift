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
    
    fileprivate var currentRound: [Event] = [] {
        didSet {
            if currentRound.count > 0 {
                for event in currentRound {
                    print(event.id!)
                }
            }
        }
    }
    
    fileprivate let game = Game()
    private var roundNumber: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        self.tableView.isScrollEnabled = false
        self.tableView.allowsSelection = true
        self.tableView.setEditing(true, animated: true)
        
        configureRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("Shake Motion Ended")
        }
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
        
        let eventIndex = self.currentRound.index { (event: Event) -> Bool in
            return event.id == cell.event?.id
        }
        
        cell.indexLabel.text = "\(eventIndex!)"
        
        cell.showsReorderControl = false
        return cell
    }
}

extension GameController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let event = self.currentRound[sourceIndexPath.row]
        self.currentRound.remove(at: sourceIndexPath.row)
        self.currentRound.insert(event, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}


