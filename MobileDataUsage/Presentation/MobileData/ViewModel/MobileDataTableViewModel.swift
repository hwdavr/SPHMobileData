//
//  MobileDataTableViewModel.swift
//  MobileDataUsage
//
//  Created by Weidian on 15/1/20.
//  Copyright © 2020 sph. All rights reserved.
//

import Foundation

class MobileDataTableViewModel {
    
    private(set) var mobileData: [MobileData] = [MobileData]()
    
    init() {
        mobileData.append(MobileData("2004-Q3", "0.000384"))
        mobileData.append(MobileData("2004-Q2", "0.000384"))
        mobileData.append(MobileData("2004-Q1", "0.000484"))
        mobileData.append(MobileData("2003-Q3", "0.000584"))
        mobileData.append(MobileData("2003-Q2", "0.000684"))
    }
}

