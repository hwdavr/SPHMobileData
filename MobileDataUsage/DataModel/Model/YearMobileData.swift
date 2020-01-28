//
//  YearMobileData.swift
//  MobileDataUsage
//
//  Created by Weidian on 27/1/20.
//  Copyright © 2020 sph. All rights reserved.
//

import Foundation


class YearMobileData: Codable {
    var year: String
    var volume: Float
    var dropped: Bool
    
    private enum mobileDataCodingKeys: String, CodingKey {
        case year
        case volume
        case dropped
    }
    
    init(_ year: String, _ volume: Float, _ dropped: Bool) {
        self.year = year
        self.volume = volume
        self.dropped = dropped
    }
    
}
