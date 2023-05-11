//
//  ArticleServicePModel.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/11.
//

import Foundation

struct ArticleServicePModel: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [ArticlePModel]?
    
    static func converTo(articleService: ArticleService) -> ArticleServicePModel {
        return ArticleServicePModel(
            status: articleService.status,
            totalResults: articleService.totalResults,
            articles: articleService.articles.map {$0.map {ArticlePModel.convertTo(article: $0)}}
        )
    }
}
