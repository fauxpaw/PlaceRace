//
//  RouteCreator.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/25/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import Foundation

//WORKFLOW
//Get a list of n objectives
//truncate list to desired value
//if value is > 5 split the list
//permutate array or sub-arrays
//

class RouteCreator {
    
    init() {}
    static let shared = RouteCreator()
    
    func evaluateDistance(a: Double, b: Double) -> Bool {
        
        let baseDistance = a
        let newDis = b
        let accpetableDisparity = 0.05
        let upperBound = baseDistance * (1 + accpetableDisparity)
        let lowerBound = baseDistance * (1 - accpetableDisparity)
        
        if newDis >= lowerBound && newDis <= upperBound{
            return true
        }
        
        return false
    }
    
    func truncateObjectivesList(toDesiredAmount number: Int, withList list: inout[Objective]) -> [Objective] {
        
        while list.count > number {
            let remove = arc4random_uniform(UInt32(list.count))
            list.remove(at: Int(remove))
        }
        
        return list
    }
    
    func evaluateInputLength(input: [Objective]) -> [[Objective]] {
        
        let output = [[Objective]]()
        
        if input.count > 5 {
            let splitValue = input.count / 2
            //split the array and call evaluate input again
        }
        
        return output
    }
    
    func findPossibleCombinations(input: [Objective]) -> [[Objective]] {
        
        let baseDistance = self.calculateRouteDistance(input: input)
        var output = [[Objective]]()
        var iterations = 0
        var count = 0
        
        func permuteWirth(_ a: [Objective], _ n: Int) {
            if n == 0 {
                //print(a) // display the current permutation
                let distance = self.calculateRouteDistance(input: a)
                
                if self.evaluateDistance(a: baseDistance, b: distance) {
                    output.append(a)
                    count += 1
                }
                
                iterations += 1
            } else {
                var a = a
                permuteWirth(a, n - 1)
                for i in 0..<n {
                    swap(&a[i], &a[n])
                    permuteWirth(a, n - 1)
                    swap(&a[i], &a[n])
                }
            }
        }
        
        permuteWirth(input, input.count - 1)
        print("Performed \(iterations) checks")
        print("Valid routes found: \(count)")
        return output
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
