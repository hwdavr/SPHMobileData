//
//  DefaultMobileDataRepositoryTest.swift
//  MobileDataUsageTests
//
//  Created by Weidian on 28/1/20.
//  Copyright © 2020 sph. All rights reserved.
//

import XCTest

class DefaultMobileDataRepositoryTest: XCTestCase {

    class TestError: Error {
        
    }
    
    class NetworkServiceMock: NetworkService {
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
        service = NetworkServiceMock()
        storage = MobileDataStorageMock()
        repository = DefaultMobileDataRepository(apiService: service, storage: storage)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMobileDataDrive() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        repository.mobileDataDrive { (result) in
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
        }
    }
}
