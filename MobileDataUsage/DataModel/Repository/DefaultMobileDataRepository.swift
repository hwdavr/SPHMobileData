//
//  DefaultMobileDataRepository.swift
//  MobileDataUsage
//
//  Created by Weidian on 27/1/20.
//  Copyright © 2020 sph. All rights reserved.
//

import Foundation

protocol MobileDataRepository {
    func mobileData(_ completion: @escaping (Result<[YearMobileData], Error>) -> Void)
}

class DefaultMobileDataRepository: MobileDataRepository {
    private let apiService: NetworkService!
    private let storage: MobileDataStorage!
    
    init(apiService: NetworkService, storage: MobileDataStorage) {
        self.apiService = apiService
        self.storage = storage
    }
    
    func mobileData(_ completion: @escaping (Result<[YearMobileData], Error>) -> Void) {
        apiService.fetchMobileData() { [weak self] result in
            switch result {
            case .success(let mobileData):
                completion(.success(mobileData))
                break
            case .failure(let error):
                self?.storage.retrieveMobileData(completion: completion)
                break
            }
        }
    }
}
