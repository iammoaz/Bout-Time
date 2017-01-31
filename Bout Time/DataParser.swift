//
//  DataParser.swift
//  Bout Time
//
//  Created by Muhammad Moaz on 1/31/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import Foundation

struct DataParser {
    private (set) var events: [Event] = []
    
    init(dictionary: [Any]?) {
        if let dictionary = dictionary {
            for object in dictionary {
                let event = Event(dictionary: object as! [String: AnyObject])
                self.events.append(event)
            }
        }
    }
}
