//
//  Game.swift
//  Bout Time
//
//  Created by Muhammad Moaz on 1/31/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import Foundation

struct Game {
    private (set) var events: [Event] = []
    private (set) var rounds: [[Event]] = []
    
    init() {
        self.events.removeAll()
        
        DataService.instance.fetch { (objects) in
            if let objects = objects {
                for event in objects.events {
                    self.events.append(event)
                }
            }
        }
    }
}
