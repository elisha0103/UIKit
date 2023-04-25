//
//  City.swift
//  WeatherList
//
//  Created by 진태영 on 2023/04/25.
//

import Foundation

struct City: Codable {
    let cityName: String
    let state: Int
    let celsius: Double
    let rainfall: Int
    
    enum CodingKeys: String, CodingKey {
        case cityName = "city_name"
        case state, celsius
        case rainfall = "rainfall_probability"
    }
}
