//
//  NetworkApi.swift
//  MobileDataUsage
//
//  Created by Weidian on 26/1/20.
//  Copyright © 2020 sph. All rights reserved.
//

import Foundation

protocol NetworkService {
    func fetchMobileData(_ completion: @escaping (Result<[YearMobileData], Error>) -> Void)
}

class NetworkApi: NetworkService {
    
    private func parsingData(data: Data) -> [YearMobileData] {
        if let json = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            if let result = json["result"] as? [String: Any] {
                if let records = result["records"] as? [[String: Any]] {
                    var mobileDataDict = [String: YearMobileData]()
                    var previousVolume: Float = 0.0
                    for record in records {
                        guard let quarter = record["quarter"] as? String else {
                            continue
                        }
                        let offset = quarter.index(quarter.startIndex, offsetBy: 4)
                        let year = String(quarter[..<offset])
                        // filter out the years not within range
                        if year >= "2008" && year < "2019" {
                            guard let quarterVolume = record["volume_of_mobile_data"] as? NSString else {
                                continue
                            }
                            var dropped = false
                            if quarterVolume.floatValue < previousVolume {
                                dropped = true
                            }
                            if let mobileData = mobileDataDict[year] {
                                mobileData.volume += quarterVolume.floatValue
                                if dropped {
                                    mobileData.dropped = dropped
                                }
                            } else {
                                let mobileData = YearMobileData(year, quarterVolume.floatValue, dropped)
                                mobileDataDict[year] = mobileData
                            }
                            previousVolume = quarterVolume.floatValue
                        }
                    }

                    let mobileDataResult = YearMobileDataResults(from: mobileDataDict)
                    if mobileDataDict.count > 0 {
                        UserDefaultsStorage().saveMobileData(mobileData: mobileDataResult)
                    }
                    return mobileDataResult.records
                }
            }
        }
        return []
    }
    
    func fetchMobileData(_ completion: @escaping (Result<[YearMobileData], Error>) -> Void) {
        let url = URL(string: "https://data.gov.sg/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f&limit=58")!
        let request = URLRequest(url: url)
            
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                let mobileData = self.parsingData(data: data!)
                completion(.success(mobileData))
            }
        }.resume()
    }
}

