//
//  LandingController.swift
//  Bout Time
//
//  Created by Muhammad Moaz on 2/2/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import UIKit

class LandingController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startButtonTapped(sender: UIButton) {
        performSegue(withIdentifier: "GameController", sender: nil)
    }

}
