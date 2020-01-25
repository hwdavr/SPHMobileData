//
//  MobileDataTableViewController.swift
//  MobileDataUsage
//
//  Created by Weidian on 15/1/20.
//  Copyright © 2020 sph. All rights reserved.
//

import UIKit

class MobileDataTableViewController: UITableViewController {
    private(set) var viewModel: MobileDataTableViewModel!
    
    // Builder pattern
    static func build(with viewModel: MobileDataTableViewModel) -> MobileDataTableViewController {
        let storageBoard = UIStoryboard(name: "MobileDataTableView", bundle: nil)
        let viewController = storageBoard.instantiateViewController(withIdentifier: "mobileDataTableView")
        guard let mViewController = viewController as? MobileDataTableViewController else {
            fatalError("Cannot instantiate view controller")
        }
        mViewController.viewModel = viewModel
        return mViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = MobileDataTableItemCell.HEIGHT
        tableView.rowHeight = UITableView.automaticDimension
    }
    
}

extension MobileDataTableViewController {
    
}
