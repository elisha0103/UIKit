//
//  TV.swift
//  TVMOVIEProject
//
//  Created by 진태영 on 2023/08/28.
//

import Foundation

struct TVListModel: Decodable {
    let page: Int
    let results: [TV]
}

struct TV: Decodable, Hashable {
    let name: String
    let overView: String
    let posterURL: String
    let vote: String
    let firstAirDate: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case overView = "overview"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        overView = try container.decode(String.self, forKey: .overView)
        let path = try container.decode(String.self, forKey: .posterPath)
        posterURL = "https://image.tmdb.org/t/p/w500\(path)"
        let voteAverage = try container.decode(Float.self, forKey: .voteAverage)
        let voteCount = try container.decode(Int.self, forKey: .voteCount)
        vote = "\(voteAverage) (\(voteCount))"
        firstAirDate = try container.decode(String.self, forKey: .firstAirDate)
    }
}
