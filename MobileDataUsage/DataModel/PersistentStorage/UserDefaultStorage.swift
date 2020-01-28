//
//  UserDefaultStorage.swift
//  MobileDataUsage
//
//  Created by Weidian on 27/1/20.
//  Copyright © 2020 sph. All rights reserved.
//

import Foundation

final class UserDefaultsStorage: MobileDataStorage {
    private let mobileDataQueriesKey = "mobileDataQueries"
    private var userDefaults: UserDefaults { return UserDefaults.standard }
    
    func saveMobileData(mobileData: YearMobileDataResults) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(mobileData) {
            userDefaults.set(encoded, forKey: mobileDataQueriesKey)
        }
    }
    
    func retrieveMobileData(completion: @escaping (Result<[YearMobileData], Error>) -> Void) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let strongSelf = self else { return }
            if let queriesData = strongSelf.userDefaults.object(forKey: strongSelf.mobileDataQueriesKey) as? Data {
                let decoder = JSONDecoder()
                if let mobileData = try? decoder.decode(YearMobileDataResults.self, from: queriesData) {
                    completion(.success(mobileData.records))
                }
            }
        }
    }
}

