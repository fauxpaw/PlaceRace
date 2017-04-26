//
//  ShuffleTest.swift
//  PlaceRace
//
//  Created by Michael Sweeney on 4/25/17.
//  Copyright © 2017 Michael Sweeney. All rights reserved.
//

import XCTest
import Foundation

class ShuffleTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testShuffle() {
        
        let collection = [1,2,3,4,5]
        var copied = collection
        
        if collection.count < 2 {return}
        
        for i in copied.startIndex ..< copied.endIndex - 1 {
            
            let j = Int(arc4random_uniform(UInt32(collection.endIndex - i))) + i
            if i != j {
                swap(&copied[i], &copied[j])
            }
        }
        
        XCTAssertNotEqual(collection, copied)
        
    }
    
    func testPossibleCombinations() {
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            let array = [1,2,3,4,5,6,7]
            
            func permuteWirth<T>(_ a: [T], _ n: Int) {
                if n == 0 {
                    print(a)   // display the current permutation
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
            
            permuteWirth(array, array.count - 1)
        }
    }
    
}
