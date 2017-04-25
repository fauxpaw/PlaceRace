//
//  ObjectiveTests.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/21/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import XCTest
@testable import PlaceRace

class ObjectiveTests: XCTestCase {
    
    var myData = Data()
    
    override func setUp() {
        super.setUp()
        guard let jsonPath = Bundle.main.url(forResource: "place", withExtension: "json") else { print("no json path"); return}
        
        do {
            myData = try Data(contentsOf: jsonPath)
            
        } catch {
            print("no valid Data")
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testValidRootObject() {
        
        do {
            if let rootObject = try JSONSerialization.jsonObject(with: myData, options: .mutableContainers) as? [String: Any] {
                XCTAssertNotNil(rootObject)
            }
        } catch {
           print(error.localizedDescription)
        }
    }
    
    func testValidArrayOfDictionaries() {
        
        
        
    }
    
    
}
