//
//  APIEndpoints.swift
//  BoxOffice
//
//  Created by 진태영 on 2023/05/09.
//

import Foundation

struct APIEndpoints {
    
    static func getMovies(with moviesRequest: MoviesRequest) -> EndPoint<Movies> {
        return EndPoint(baseURL: "https://connect-boxoffice.run.goorm.io/", path: "movies", method: .get, queryParameters: moviesRequest)
    }
    
    static func getPoster(path: String, width: Int) -> EndPoint<Data> {
        let sizes = [92, 154, 185, 342, 500, 780]
        let closesWidth = sizes.enumerated().min {abs($0.1 - width) < abs($1.1 - width)}?.element ?? sizes.first
        
        return EndPoint(baseURL: path, path: "", method: .get)
    }
}

