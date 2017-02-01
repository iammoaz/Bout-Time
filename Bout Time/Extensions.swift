//
//  Extensions.swift
//  Bout Time
//
//  Created by Muhammad Moaz on 2/1/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import Foundation

extension Array {
    mutating func shuffle() {
        for _ in 0..<(count - 1) {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}

extension Collection {
    func chunk(by distance: IndexDistance) -> [[SubSequence.Iterator.Element]] {
        var index = startIndex
        let iterator: AnyIterator<Array<SubSequence.Iterator.Element>> = AnyIterator {
            defer {
                index = self.index(index, offsetBy: distance, limitedBy: self.endIndex) ?? self.endIndex
            }
            
            let newIndex = self.index(index, offsetBy: distance, limitedBy: self.endIndex) ?? self.endIndex
            let range = index ..< newIndex
            return index != self.endIndex ? Array(self[range]) : nil
        }
        return Array(iterator)
    }
}
