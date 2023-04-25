//
//  Country.swift
//  WeatherList
//
//  Created by 진태영 on 2023/04/25.
//

import Foundation

struct Country: Codable {
    let koreanName: String
    let assetName: String
    
    enum CodingKeys: String, CodingKey {
        case koreanName = "korean_name"
        case assetName = "asset_name"
    }
}
