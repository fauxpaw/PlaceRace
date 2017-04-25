//
//  ObjectiveFactory.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/25/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import Foundation


final class ObjectiveFactory {
    
    private init() { }
    
    static let shared = ObjectiveFactory()
    
    func createObjectives(fromArrayOfDict arrayInput: [[String: Any]]) -> [Objective] {
        
        var output = [Objective]()
        
        for dict in arrayInput {
            
            if let place = Objective(json: dict) {
                output.append(place)
            }
        }
        
        return output
    }
    
    
    
}
