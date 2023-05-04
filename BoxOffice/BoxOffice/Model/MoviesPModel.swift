//
//  MoviesPModel.swift
//  BoxOffice
//
//  Created by 진태영 on 2023/05/04.
//

import Foundation

struct MoviesPModel: Codable {
    let orderType: Int
    let movies: [Movie]
    
    static func convertTo(movies: Movies) -> MoviesPModel {
        return MoviesPModel(
            orderType: movies.orderType,
            movies: movies.movies
        )
    }
}
