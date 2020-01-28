//
//  MobileDataTableViewModel.swift
//  MobileDataUsage
//
//  Created by Weidian on 15/1/20.
//  Copyright © 2020 sph. All rights reserved.
//

import Foundation

class MobileDataTableViewModel: ViewModelType {
    let repository: MobileDataRepository!
    
    struct Input {
    }
    
    struct Output {
        let mobileDataItems: Observable<[MobileDataTableItemViewModel]> = Observable([])
    }
    
    init(_ repo: MobileDataRepository) {
        self.repository = repo
    }
    
    func transform(input: MobileDataTableViewModel.Input?) -> MobileDataTableViewModel.Output {
        let output = Output()
        repository.mobileData() { [weak self] result in
            switch result {
            case .success(let mobileData):
                output.mobileDataItems.value = mobileData.map {
                    MobileDataTableItemViewModel($0.year, $0.volume.description, $0.dropped)
                }
                break
            case .failure(let _):
                break
            }
            
        }
        
        return output
    }
}

