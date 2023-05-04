//
//  NewComment.swift
//  BoxOffice
//
//  Created by 진태영 on 2023/05/04.
//

import Foundation

struct NewComment: Codable {
    let rating: Int
    let writer, movieID, contents: String

    enum CodingKeys: String, CodingKey {
        case rating, writer
        case movieID = "movie_id"
        case contents
    }
}
