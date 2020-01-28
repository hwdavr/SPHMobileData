//
//  MobileDataTableViewModelTest.swift
//  MobileDataUsageTests
//
//  Created by Weidian on 28/1/20.
//  Copyright © 2020 sph. All rights reserved.
//

import XCTest

class MobileDataTableViewModelTest: XCTestCase {
    
    class MobileDataRepositoryMock: MobileDataRepository {
        func mobileData(_ completion: @escaping (Result<[YearMobileData], Error>) -> Void) {
            completion(.success([MockMobileData, MockMobileData]))
        }
    }
    
    var vm: MobileDataTableViewModel!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vm = MobileDataTableViewModel(MobileDataRepositoryMock())
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTransform() {
        let output = vm.transform(input: nil)
        let expectation = XCTestExpectation(description: "Start Test")
        output.mobileDataItems.observe(on: self) { [weak self] data in
            XCTAssertTrue(data.count == 2)
            XCTAssertEqual(data[0].year, MockMobileData.year)
            XCTAssertEqual(data[0].volume, MockMobileData.volume.description)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
