//
//  Event.swift
//  Bout Time
//
//  Created by Muhammad Moaz on 1/31/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import Foundation

struct Event {
    private (set) var id: Int?
    private (set) var text: String?
    private (set) var year: String?
    private (set) var url: String?
    
    init(dictionary: [String: AnyObject]) {
        if let id = dictionary["id"] as? Int {
            self.id = id
        }
        
        if let text = dictionary["text"] as? String {
            self.text = text
        }
        
        if let year = dictionary["year"] as? String {
            self.year = year
        }
        
        if let url = dictionary["url"] as? String {
            self.url = url
        }
    }
}
