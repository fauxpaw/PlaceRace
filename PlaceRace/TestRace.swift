//
//  TestRace.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/27/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import Foundation
import Parse

class TestRace: PFObject, PFSubclassing {
    
    
    let routes : [[Objective]]
    
    init(input: [[Objective]]) {
        self.routes = input
        super.init()
    }
    
    static func parseClassName() -> String {
        return "TestRace"
    }
    
}
