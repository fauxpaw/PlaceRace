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
    
    fileprivate func evaluateNewListOrder( input: inout[Objective]) -> [Objective] {
        
        
        let newOrder = input.shuffle()
        
        
        return input
    }
    
    func calculateRouteDistance() {
        
    }
    
}
