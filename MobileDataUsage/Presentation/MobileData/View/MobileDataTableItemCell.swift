//
//  MobileDataTableItemCell.swift
//  MobileDataUsage
//
//  Created by Weidian on 15/1/20.
//  Copyright © 2020 sph. All rights reserved.
//

import UIKit

class MobileDataTableItemCell: UITableViewCell {
    static internal let HEIGHT = CGFloat(56)
    static internal let REUSE_IDENTIFIER = "MobileDataTableItemCell"
    
    internal let lblYear = UILabel()
    internal var lblVolume = UILabel()
    internal var btnDropped = UIButton()
    var btnHeightConstraint : NSLayoutConstraint!
    var btnWidthConstraint : NSLayoutConstraint!
    
    let btnSize = 24.0 as CGFloat
    
    func initialize() {
        btnDropped.setImage(UIImage(named:"decrease.png"), for: .normal)
        btnDropped.contentMode = .scaleAspectFit
        btnDropped.addTarget(self, action: #selector(droppedButtonAction(_:)), for: .touchDown)
        contentView.addSubview(btnDropped)
        btnDropped.translatesAutoresizingMaskIntoConstraints = false
        btnHeightConstraint = btnDropped.heightAnchor.constraint(equalToConstant: btnSize)
        btnHeightConstraint.isActive = true
        btnWidthConstraint = btnDropped.widthAnchor.constraint(equalToConstant: btnSize)
        btnWidthConstraint.isActive = true
        btnDropped.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        contentView.centerYAnchor.constraint(equalTo: (btnDropped.centerYAnchor)).isActive = true
        btnDropped.isHidden = true

        contentView.addSubview(lblYear)
        lblYear.translatesAutoresizingMaskIntoConstraints = false
        lblYear.widthAnchor.constraint(equalToConstant: 220).isActive = true
        lblYear.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lblYear.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        lblYear.topAnchor.constraint(equalTo: topAnchor, constant: 6).isActive = true

        lblVolume.textColor = UIColor.gray
        lblVolume.font = lblVolume.font.withSize(12)
        contentView.addSubview(lblVolume)
        lblVolume.translatesAutoresizingMaskIntoConstraints = false
        lblVolume.widthAnchor.constraint(equalToConstant: 220).isActive = true
        lblVolume.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lblVolume.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        lblVolume.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: MobileDataTableItemCell.REUSE_IDENTIFIER)
        initialize()
    }
    
    required init(coder aDecoder: NSCoder) {
        //super.init(coder: aDecoder)
        super.init(style: .default, reuseIdentifier: MobileDataTableItemCell.REUSE_IDENTIFIER)
        initialize()
    }
    
    @objc func droppedButtonAction(_ sender: UIButton) {
        print("Certain quarter decreased in this year!")
    }
}
