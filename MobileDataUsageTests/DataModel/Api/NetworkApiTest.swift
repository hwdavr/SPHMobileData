//
//  NetworkApiTest.swift
//  MobileDataUsageTests
//
//  Created by Weidian on 27/1/20.
//  Copyright © 2020 sph. All rights reserved.
//

import XCTest

class NetworkApiTest: XCTestCase {
    let api = NetworkApi()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchMobileData() {
        let expectation = XCTestExpectation(description: "Start HTTP request")
        api.fetchMobileData({ (result) in
            switch result {
            case .success(let mobileData):
                print(mobileData)
                XCTAssertTrue(mobileData.count > 0)
                break
            case .failure(let error):
                assertionFailure()
                break
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 30.0)
    }

}
