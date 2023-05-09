//
//  MoviesRequest.swift
//  BoxOffice
//
//  Created by 진태영 on 2023/05/09.
//

import Foundation

struct MoviesRequest: Codable {
    let order: Int // 0: 예매율, 1: 큐레이션, 2: 개봉일
    
    enum CodingKeys: String, CodingKey {
        case order = "order_type"
    }
}
