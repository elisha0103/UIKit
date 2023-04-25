//
//  ContryPModel.swift
//  WeatherList
//
//  Created by 진태영 on 2023/04/25.
//

import Foundation

struct CountryPModel {
    let koreanName: String
    let assetName: String
    
    
    static func convertTo(_ country: Country) -> CountryPModel {
        return CountryPModel(koreanName: country.koreanName, assetName: country.assetName)
    }
}
