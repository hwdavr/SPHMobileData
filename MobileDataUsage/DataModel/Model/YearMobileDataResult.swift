//
//  YearMobileDataResult.swift
//  MobileDataUsage
//
//  Created by Weidian on 27/1/20.
//  Copyright © 2020 sph. All rights reserved.
//

import Foundation

class YearMobileDataResults: Codable {
    var records: [YearMobileData]
    
    private enum CodingKeys: String, CodingKey {
        case records
    }
    
    required init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var records = [YearMobileData]()
        if let count = container.count {
            records.reserveCapacity(count)
        }

        while !container.isAtEnd {
            let record = try container.decode(YearMobileData.self)
            records.append(record)
        }

        self.records = records
    }
    
    init(from dict: [String: YearMobileData]) {
        records = [YearMobileData]()
        let keys = Array(dict.keys)
        for key in keys.sorted(by: { $0 < $1 }) {
            let value = dict[key]!
            records.append(value)
        }
    }
    
    init(from list: [YearMobileData]) {
        records = list
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(records)
    }
}


