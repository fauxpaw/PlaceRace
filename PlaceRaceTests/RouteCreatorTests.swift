//
//  RouteCreatorTests.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/25/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Pods_PlaceRace

class RouteCreatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testListTruncateAlgorithm() {
        var list = [1,2,3,4,5,6,7,8,9,10]
        let desired = 5
        
        while list.count > desired {
            let remove = arc4random_uniform(UInt32(list.count))
            list.remove(at: Int(remove))
        }

        XCTAssertTrue(list.count == desired)
        
    }
    
    func testValidRouteLengthAlgorithm() {
        let base = 1000.0
        let disparity = 0.05
        let route = 1010.0
        let upper = base * (1 + disparity)
        let lower = base * (1 - disparity)
        XCTAssertTrue(route >= lower && route <= upper)
        
    }
    
    func testSplitArrayAlgorithm () {
        
        let array = [1,2,3,4,5,6,7,8,9,10]
        var newArr = [[Int]]()
        
        if array.count > 5 {
            let slice = array.count / 2
            let leftSide = array[0..<slice]
            let rightSide = array[slice..<array.count]
            let left: [Int] = Array(leftSide)
            let right: [Int] = Array(rightSide)
            newArr.append(left)
            newArr.append(right)
            
        }
    }
    
    func testValidRouteEvaulation() {
        // This is an example of a performance test case.
        self.measure {
            
        }
    }
}
