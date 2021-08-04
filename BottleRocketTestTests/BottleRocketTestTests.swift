//
//  BottleRocketTestTests.swift
//  BottleRocketTestTests
//
//  Created by Ignacio J Gonzalez Pérez on 03/08/21.
//

import XCTest
@testable import BottleRocketTest

class BottleRocketTestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let expectation = expectation(description: "request")
        
        RemoteRepository().getRestaurants { restaurants, error in
            
            XCTAssertNotNil(restaurants)
            XCTAssertNil(error)
            XCTAssert(restaurants!.count > 0)

            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
