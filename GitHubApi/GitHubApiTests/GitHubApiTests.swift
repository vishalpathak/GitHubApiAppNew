//
//  GitHubApiTests.swift
//  GitHubApiTests
//
//  Created by vishal dilip pathak on 10/07/19.
//  Copyright © 2019 VishalP. All rights reserved.
//

import XCTest
@testable import GitHubApi

class GitHubApiTests: XCTestCase {

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
    //MARK: Check Valid Date String. Tested with Different Date formats and checked that is it valid string or nil String.
    func testValidDateString() {
        let objCommon = CommonFunctions()
        let dateStr = objCommon.convertDateFormater(strDT: "2019-02-12T14:20:45Z", givenFormat: "yyyy-MM-dd'T'HH:mm:ssZ", expectedFormat: "dd/MM/yyyy")
        print(dateStr)
        XCTAssertNotNil(dateStr)
         let dateStr1 = objCommon.convertDateFormater(strDT: "Mar-2019-21", givenFormat: "MMM-yyyy-dd", expectedFormat: "dd/MM/yyyy")
        print(dateStr1)
        XCTAssertNotNil(dateStr1)
    }

}
