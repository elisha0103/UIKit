//
//  CommentsPModel.swift
//  BoxOffice
//
//  Created by 진태영 on 2023/05/04.
//

import Foundation

struct CommentsPModel: Codable {
    let comments: [Comment]
    
    static func converTo(comments: Comments) -> CommentsPModel {
        return CommentsPModel(comments: comments.comments)
    }
}
