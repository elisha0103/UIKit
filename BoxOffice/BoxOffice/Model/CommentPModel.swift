//
//  CommentPModel.swift
//  BoxOffice
//
//  Created by 진태영 on 2023/05/04.
//

import Foundation

struct CommentPModel: Codable {
    let id: String?
    let rating: Int?
    let timestamp: Double?
    let writer, movieID: String?
    let contents: String
    
    static func converTo(comment: Comment) -> CommentPModel {
        return CommentPModel(
            id: comment.id,
            rating: comment.rating,
            timestamp: comment.timestamp,
            writer: comment.writer,
            movieID: comment.movieID,
            contents: comment.contents
        )
    }
}
