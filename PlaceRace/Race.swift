//
//  Race.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/9/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import Foundation
import Parse

class Race: PFObject {
    
    let creator = PFUser.current()
    var host = PFUser.current()
    var currentPlayers: [PFUser]
    //var code: Int
    var maxPlayers: Int
    var objectives: [Objective]
    var timeLimit: TimeInterval
    //let routes: [String: Any]
    
    init(playerCount: Int) {
        
        self.maxPlayers = playerCount
        self.currentPlayers = [PFUser.current()!]
        self.objectives = [Objective]()
        self.timeLimit = 90
        super.init()
    }
}
