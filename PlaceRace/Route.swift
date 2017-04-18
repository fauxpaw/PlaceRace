//
//  Route.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/9/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import Foundation
import Parse

struct Route {
    
    let objectives: [Objective]
    
    init(objectives: [Objective]) {
        self.objectives = objectives
    }
}
