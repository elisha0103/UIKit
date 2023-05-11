//
//  ArticlePModel.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/11.
//

import Foundation

struct ArticlePModel: Codable, Hashable {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    
    static func convertTo(article: Article) -> ArticlePModel {
        return ArticlePModel(
            author: article.author,
            title: article.title,
            description: article.description,
            url: article.url,
            urlToImage: article.urlToImage,
            publishedAt: article.publishedAt
        )
    }
}
