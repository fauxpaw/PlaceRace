//
//  Route.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/27/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import Foundation

class Route {
    
    let waypoints: [Objective]
    
    init(input: [Objective]) {
        self.waypoints = input
    }
    
    func getTotalDistance() {
        
        var totalDis = 0.0
        
        for (i, place) in waypoints.enumerated() {
            if i > 0 && i < waypoints.count - 1 {
                
                let loc1 = waypoints[i-1].getCLLocation()
                let loc2 = place.getCLLocation()
                totalDis += loc1.distance(from: loc2)
            }
        }
        print("Route distance is: \(totalDis)")
    }
}
