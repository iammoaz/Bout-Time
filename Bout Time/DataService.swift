//
//  DataService.swift
//  Bout Time
//
//  Created by Muhammad Moaz on 1/31/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import Foundation

class DataService {
    static let instance = DataService()
    
    private let bundle: Bundle
    private let url: URL
    
    init() {
        self.bundle = Bundle(for: type(of: self))
        self.url = bundle.url(forResource: "data", withExtension: "json")!
    }
    
    func fetch(completion: (DataParser?) -> Void) {
        guard let data = try? Data(contentsOf: self.url) else { return }
        guard let json = try? JSONSerialization.jsonObject(with: data) as! [Any] else { return }
        let events = DataParser(dictionary: json)
        completion(events)
    }
}
