//
//  MobileData.swift
//  MobileDataUsage
//
//  Created by Weidian on 16/1/20.
//  Copyright © 2020 sph. All rights reserved.
//

import Foundation

class MobileData: Decodable {
    var quarter: String
    var volume: String
    
    private enum mobileDataCodingKeys: String, CodingKey {
        case quarter
        case volume
    }
    
    init(_ quarter: String, _ volume: String) {
        self.quarter = quarter
        self.volume = volume
    }
    
}
