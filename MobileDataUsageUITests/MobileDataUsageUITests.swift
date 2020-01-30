//
//  MobileDataUsageUITests.swift
//  MobileDataUsageUITests
//
//  Created by Weidian on 15/1/20.
//  Copyright © 2020 sph. All rights reserved.
//

import XCTest

class MobileDataUsageUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMobileDataUsage() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Assert that we are displaying the tableview
        let tableView = app.tables["mobileDataTable"]
        XCTAssertTrue(tableView.exists, "The tableview exists")
        // Get an array of cells
        let tableCells = tableView.cells

        if tableCells.count > 0 {
            let count: Int = (tableCells.count - 1)
         
            let promise = expectation(description: "Wait for table cells")
            var visibleCount = 0
         
            for i in stride(from: 0, to: count , by: 1) {
                // Grab the cell and verify that it exists
                let tableCell = tableCells.element(boundBy: i)
                XCTAssertTrue(tableCell.exists, "The \(i) cell is in place on the table")

                if tableCell.buttons["button-decreasing"].exists {
                    visibleCount += 1
                }
         
                if i == (count - 1) {
                    promise.fulfill()
                }
            }
            waitForExpectations(timeout: 20, handler: nil)
            XCTAssertTrue(true, "Finished validating the table cells")
            XCTAssertEqual(visibleCount, 3)
        } else {
            XCTAssert(false, "Was not able to find any table cells")
        }
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
