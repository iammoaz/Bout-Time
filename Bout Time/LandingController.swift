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

    @IBAction func startButtonTapped(sender: UIButton) {
        performSegue(withIdentifier: "GameController", sender: nil)
    }

}
