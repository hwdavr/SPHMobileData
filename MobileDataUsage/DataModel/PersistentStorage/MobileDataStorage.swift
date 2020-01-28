//
//  MobileDataStorage.swift
//  MobileDataUsage
//
//  Created by Weidian on 27/1/20.
//  Copyright © 2020 sph. All rights reserved.
//

import Foundation

protocol MobileDataStorage {
    func retrieveMobileData(completion: @escaping (Result<[YearMobileData], Error>) -> Void)
    func saveMobileData(mobileData: YearMobileDataResults)
}
