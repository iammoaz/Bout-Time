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
    
    fileprivate var rounds: [[Event]] = []
    fileprivate let game = Game()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
