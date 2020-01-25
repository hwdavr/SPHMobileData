//
//  MobileDataTableItemCell.swift
//  MobileDataUsage
//
//  Created by Weidian on 15/1/20.
//  Copyright © 2020 sph. All rights reserved.
//

import UIKit

class MobileDataTableItemCell: UITableViewCell {
    static internal let HEIGHT = CGFloat(80)
    static internal let REUSE_IDENTIFIER = "MobileDataTableItemCell"
    
    @IBOutlet private var lblQuarter: UILabel!
    @IBOutlet private var lblVolume: UILabel!
    @IBOutlet private var imageDecrease: UIImageView!
    
    
    
}
