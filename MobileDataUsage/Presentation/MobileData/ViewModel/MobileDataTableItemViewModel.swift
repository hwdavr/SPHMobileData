//
//  MobileDataTableItemViewModel.swift
//  MobileDataUsage
//
//  Created by Weidian on 15/1/20.
//  Copyright © 2020 sph. All rights reserved.
//

import Foundation

class MobileDataTableItemViewModel {
    var year: String
    var volume: String
    var decreased: Bool
    
    init(_ year: String, _ volume: String, _ decreased: Bool) {
        self.year = year
        self.volume = volume
        self.decreased = decreased
    }
}
