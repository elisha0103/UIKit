//
//  Movies.swift
//  BoxOffice
//
//  Created by 진태영 on 2023/05/04.
//

import Foundation

struct Movies: Codable {
    let orderType: Int
    let movies: [Movie]

    enum CodingKeys: String, CodingKey {
        case orderType = "order_type"
        case movies
    }
}
