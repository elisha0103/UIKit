//
//  NewCommentPModel.swift
//  BoxOffice
//
//  Created by 진태영 on 2023/05/04.
//

import Foundation

struct NewCommentPModel: Codable {
    let rating: Int
    let writer, movieID, contents: String
    
    static func converTo(newComment: NewComment) -> NewCommentPModel {
        return NewCommentPModel(
            rating: newComment.rating,
            writer: newComment.writer,
            movieID: newComment.movieID,
            contents: newComment.contents
        )
    }
}
