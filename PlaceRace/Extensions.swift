//
//  Extensions.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/25/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import Foundation

extension MutableCollection where Index == Int {
    
    mutating func shuffle() {
        
        if count < 2 { return }
        
        for currentPos in startIndex ..< endIndex - 1 {
            
            let destination = Int(arc4random_uniform(UInt32(endIndex - 1))) + currentPos
            if currentPos != destination {
                swap(&self[currentPos], &self[destination])
            }
            
        }
    }
    
}
