//
//  DefaultMobileDataRepositoryTest.swift
//  MobileDataUsageTests
//
//  Created by Weidian on 28/1/20.
//  Copyright © 2020 sph. All rights reserved.
//

import XCTest

class DefaultMobileDataRepositoryTest: XCTestCase {
    
    class NetworkServiceSuccessMock: NetworkService {
        func fetchMobileData(_ completion: @escaping (Result<[YearMobileData], Error>) -> Void) {
            completion(.success([MockMobileData]))
        }
    }
    
    class NetworkServiceFailedMock: NetworkService {
        func fetchMobileData(_ completion: @escaping (Result<[YearMobileData], Error>) -> Void) {
            completion(.failure(TestError()))
        }
    }
    
    class MobileDataStorageMock: MobileDataStorage {
        func retrieveMobileData(completion: @escaping (Result<[YearMobileData], Error>) -> Void) {
            completion(.success([MockMobileData, MockMobileData]))
        }
        func saveMobileData(mobileData: YearMobileDataResults) {
            
        }
    }
    
    var service: NetworkService!
    var storage: MobileDataStorage!
    var repository: DefaultMobileDataRepository!
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMobileDataOffline() {
        service = NetworkServiceFailedMock()
        storage = MobileDataStorageMock()
        repository = DefaultMobileDataRepository(apiService: service, storage: storage)
        let expectation = XCTestExpectation(description: "Start Test")
        repository.mobileData { (result) in
            switch result {
            case .success(let data):
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
        wait(for: [expectation], timeout: 10.0)
    }

    func testMobileDataOnline() {
        service = NetworkServiceSuccessMock()
        storage = MobileDataStorageMock()
        repository = DefaultMobileDataRepository(apiService: service, storage: storage)
        let expectation = XCTestExpectation(description: "Start Test")
        repository.mobileData { (result) in
            switch result {
            case .success(let data):
                XCTAssertTrue(data.count == 1)
                XCTAssertEqual(data[0].year, MockMobileData.year)
                XCTAssertEqual(data[0].volume, MockMobileData.volume)
                break
            case .failure(let error):
                assertionFailure()
                break
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
