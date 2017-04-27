//
//  RouteCreatorTests.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/25/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import XCTest
import CoreLocation

class RouteCreatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testValidRouteLength() {
        let base = 1000.0
        let disparity = 0.05
        let route = 1010.0
        let upper = base * (1 + disparity)
        let lower = base * (1 - disparity)
        XCTAssertTrue(route >= lower && route <= upper)
        
    }
    
    func testValidRouteEvaulation() {
        // This is an example of a performance test case.
        self.measure {
            
        }
    }
}
