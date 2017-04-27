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
//re-pair sub-arrays

class RouteCreator {
    
    private init() {}
    static let shared = RouteCreator()
    
    func getRoutes(input: inout [Objective], p: Int) -> [[Objective]] {
        
        let truncated = self.truncateObjectivesList(toDesiredAmount: p, withList: &input)
        if truncated.count > 8 {
            let lr = splitArray(input: truncated)
            let left = self.findPossibleCombinations(input: lr[0])
            let right = self.findPossibleCombinations(input: lr[1])
            return self.pairSubArrays(arr1: left, arr2: right)
        }
        
        let combos = self.findPossibleCombinations(input: truncated)
        return combos
        
        
    }
    
    fileprivate func splitArray(input: [Objective]) -> [[Objective]] {
        var output = [[Objective]]()
        let splitValue = input.count/2
        
        let leftSide = input[0..<splitValue]
        let rightSide = input[splitValue..<input.count]
        let left: [Objective] = Array(leftSide)
        let right: [Objective] = Array(rightSide)
        output.append(left)
        output.append(right)
        
        return output
    }
    
    fileprivate func pairSubArrays(arr1: [[Objective]], arr2: [[Objective]]) -> [[Objective]] {
        
        var retValue = [[Objective]]()
        
        if arr1.count == arr2.count {
            for num in 0..<arr1.count {
                let arr : [Objective] = arr1[num] + arr2[num]
                retValue.append(arr)
            }
        }
        
        if arr1.count > arr2.count {
            for num in 0..<arr1.count {
                let array : [Objective] = arr1[num] + arr2[num % arr2.count]
                retValue.append(array)
            }
        } else {
            for num in 0..<arr2.count {
                print(num % arr1.count)
                let array : [Objective] = arr1[num % arr1.count] + arr2[num]
                retValue.append(array)
            }
        }

        return retValue
    }
    
    fileprivate func truncateObjectivesList(toDesiredAmount number: Int, withList list: inout[Objective]) -> [Objective] {
        
        while list.count > number {
            let remove = arc4random_uniform(UInt32(list.count))
            list.remove(at: Int(remove))
        }
        
        return list
    }
    
    fileprivate func findPossibleCombinations(input: [Objective]) -> [[Objective]] {
        
        let baseDistance = self.calculateRouteDistance(input: input)
        var output = [[Objective]]()
        var iterations = 0
        var count = 0
        
        func permute(_ a: [Objective], _ n: Int) {
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
                permute(a, n - 1)
                for i in 0..<n {
                    swap(&a[i], &a[n])
                    permute(a, n - 1)
                    swap(&a[i], &a[n])
                }
            }
        }
        
        permute(input, input.count - 1)
        print("Performed \(iterations) checks")
        print("Valid routes found: \(count)")
        return output
    }
    
    fileprivate func calculateRouteDistance(input: [Objective]) -> Double {
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
    
    fileprivate func evaluateDistance(a: Double, b: Double) -> Bool {
        
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
    
}
