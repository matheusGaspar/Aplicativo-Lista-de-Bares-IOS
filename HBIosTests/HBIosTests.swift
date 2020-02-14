//
//  HBIosTests.swift
//  HBIosTests
//
//  Created by Jonathan on 28/01/20.
//  Copyright © 2020 Hbsis. All rights reserved.
//

import XCTest
@testable import HBIos

class HBIosTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    // Confirm that the Meal initialier returns nil when passed a negative rating or an empty name.
    func testBarInitializationFails() {
        // Negative rating
        let negativeRatingBar = Bar.init(name: "Negative", photo: nil, rating: -1, telefone: "Negative", endereco: "Negative")
        XCTAssertNil(negativeRatingBar)
        
        // Empty String
        let emptyStringBar = Bar.init(name: "", photo: nil, rating: 0, telefone: "", endereco: "")
        XCTAssertNil(emptyStringBar)
    }
    // Confirm that the Meal initializer returns a Meal object when passed valid parameters.b
    func testBarInitializationSucceeds() {
        // Zero rating
        let zeroRatingBar = Bar.init(name: "Zero", photo: nil, rating: 0, telefone: "Zero", endereco: "Zero")
        XCTAssertNotNil(zeroRatingBar)
        
        // Highest positive rating
        let positiveRatingBar = Bar.init(name: "Positive", photo: nil, rating: 5, telefone: "Positive", endereco: "Positive")
        XCTAssertNotNil(positiveRatingBar)
    }

}


