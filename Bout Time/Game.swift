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
    private (set) var rounds: ArraySlice<[Event]> = []
    private (set) var numberOfCorrectAnswers: Int = 0
    
    init() {
        self.events.removeAll()
        
        DataService.instance.fetch { (objects) in
            if let objects = objects {
                for event in objects.events {
                    self.events.append(event)
                }
            }
        }
        
        self.events.shuffle()
        self.rounds = self.events.chunk(by: 4).prefix(6)
    }
    
    mutating func checkAnswerFor(round: [Event]) -> Bool {
        let orderedArray = round.sorted{ $0.year! < $1.year! }
        let value =  round == orderedArray
        
        if value {
            self.numberOfCorrectAnswers += 1
        }
        
        return value
    }
}
