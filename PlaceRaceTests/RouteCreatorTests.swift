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
    
    func testPairSubArrays() {
        
        //let arr1 = [[1],[2],[3],[4]]
        //let arr2 = [[5],[6],[7],[8],[9]]
        
        let arr1 = [[1],[2],[3],[4],[5]]
        let arr2 = [[6],[7],[8],[9]]
        var retValue = [[Int]]()
        
        
        
        if arr1.count == arr2.count {
            for num in 0..<arr1.count {
              let arr : [Int] = arr1[num] + arr2[num]
                retValue.append(arr)
            }
        }
        
        if arr1.count > arr2.count {
            for num in 0..<arr1.count {
                let array : [Int] = arr1[num] + arr2[num % arr2.count]
                retValue.append(array)
            }
        } else {
            for num in 0..<arr2.count {
                print(num % arr1.count)
                let array : [Int] = arr1[num % arr1.count] + arr2[num]
                retValue.append(array)
            }
        }
        
        XCTAssert(retValue.count == 5)
        //XCTAssertEqual([1,5], retValue[0])
        //XCTAssertEqual([1,9], retValue[4])
        XCTAssertEqual([1,6], retValue[0])
        XCTAssertEqual([5,6], retValue[4])
        
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
        
        XCTAssertTrue(newArr.count == 2)
        XCTAssertTrue(newArr[0].count == 5 && newArr[1].count == 5)
    }
    
    func testValidRouteEvaulation() {
        // This is an example of a performance test case.
        self.measure {
            
        }
    }
}
