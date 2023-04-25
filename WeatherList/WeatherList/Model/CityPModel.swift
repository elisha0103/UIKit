//
//  CityPModel.swift
//  WeatherList
//
//  Created by 진태영 on 2023/04/25.
//

import Foundation

struct CityPModel {
    let cityName: String
    let state: Int
    let celsius: Double
    let rainfall: Int
    
    static func converTo(_ city: City) -> CityPModel {
        return CityPModel(cityName: city.cityName, state: city.state, celsius: city.celsius, rainfall: city.rainfall)
    }
}
