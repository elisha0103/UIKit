//
//  Comment.swift
//  BoxOffice
//
//  Created by 진태영 on 2023/05/04.
//

import Foundation

struct Comment: Codable {
    let id: String?
    let rating: Int?
    let timestamp: Double?
    let writer, movieID: String?
    let contents: String

    enum CodingKeys: String, CodingKey {
        case id, rating, timestamp, writer
        case movieID = "movie_id"
        case contents
    }
}
