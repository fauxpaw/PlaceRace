//
//  RouteCreator.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/25/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import Foundation

class RouteCreator {
    
    init() {}
    static let shared = RouteCreator()
    
    //take in a list of objectives, return a new order (with constraints) of objectives
    func getNewValidRoute(input: inout[Objective]) -> [Objective] {
     
        
        return input
    }
    
    func evaluateNewListOrder(input: inout[Objective]) -> Bool {
        
        let accpetableDisparity = 0.05
        let baseDistance = calculateRouteDistance(input: input)
        let upperBound = baseDistance + baseDistance * accpetableDisparity
        let lowerBound = baseDistance - baseDistance * accpetableDisparity
        
        //reorder
        input.shuffle()
        let newDis = calculateRouteDistance(input: input)
        
        print("Base Distance is: \(baseDistance)")
        print("New Distance is: \(newDis)")
        
        if newDis <= upperBound || newDis >= lowerBound {
            return true
        }
        
        //find difference
        
        //check diff vs okvalue
        
        return false
    }
    
    func calculateRouteDistance(input: [Objective]) -> Double {
        print("Input count: \(input.count)")
        //distance in meters
        var totalDis = 0.0
        
        for (i, place) in input.enumerated() {
            if i > 0 && i < input.count - 1 {

                let loc1 = input[i-1].getCLLocation()
                let loc2 = place.getCLLocation()
                totalDis += loc1.distance(from: loc2)
            }
        }
        
        return totalDis
    }
    
}
