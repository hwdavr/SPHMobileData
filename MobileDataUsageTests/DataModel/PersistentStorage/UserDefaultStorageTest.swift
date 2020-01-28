//
//  UserDefaultStorageTest.swift
//  MobileDataUsageTests
//
//  Created by Weidian on 28/1/20.
//  Copyright © 2020 sph. All rights reserved.
//

import XCTest

class UserDefaultStorageTest: XCTestCase {
    let storage = UserDefaultsStorage()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStorage() {
        let mobileDataResult = YearMobileDataResults(from: [MockMobileData, MockMobileData])
        storage.saveMobileData(mobileData: mobileDataResult)
        let expectation = XCTestExpectation(description: "Start Retrive")
        storage.retrieveMobileData { (result) in
            switch result {
            case .success(let data):
                print(data)
                XCTAssertTrue(data.count == 2)
                XCTAssertEqual(data[0].year, MockMobileData.year)
                XCTAssertEqual(data[0].volume, MockMobileData.volume)
                break
            case .failure(let error):
                assertionFailure()
                break
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30.0)
    }
}
