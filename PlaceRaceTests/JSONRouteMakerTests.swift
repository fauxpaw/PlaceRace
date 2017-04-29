//
//  JSONRouteMakerTests.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/27/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import XCTest

@testable import PlaceRace

class JSONRouteMakerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testJSONFromDictionary() {
        
        let dic = Dictionary(dictionaryLiteral: ("results", ["values"]))
        
        do {
           let obj =  try? JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
            if let json = obj {
                print(json)
            }
        } catch {
            
        }
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
