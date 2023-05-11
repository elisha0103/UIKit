//
//  Article.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/11.
//

import Foundation

struct Article: Codable, Hashable {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
}
