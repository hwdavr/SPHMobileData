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
    
    private var items: [MobileDataTableItemViewModel]! {
        didSet { tableView.reloadData() }
    }
    
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
        self.items = []
        tableView.estimatedRowHeight = MobileDataTableItemCell.HEIGHT
        tableView.rowHeight = MobileDataTableItemCell.HEIGHT
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MobileDataTableItemCell.self, forCellReuseIdentifier: MobileDataTableItemCell.REUSE_IDENTIFIER)
        
        bindViewModel()
    }
    
    private func bindViewModel() {
       let output = viewModel.transform(input: nil)
        
       output.mobileDataItems.observe(on: self) { [weak self] mobileData in
           self?.items = mobileData
       }
   }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension MobileDataTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MobileDataTableItemCell.REUSE_IDENTIFIER, for: indexPath) as? MobileDataTableItemCell else {
            fatalError("Cannot dequeue cell")
        }
        let item = items[indexPath.row]
        cell.lblYear.text = item.year
        cell.lblVolume.text = item.volume
        cell.btnDropped.isHidden = !item.decreased
        return cell
    }
}
