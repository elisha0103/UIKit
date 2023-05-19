//
//  APIEndpoints.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/19.
//

import Foundation

struct ApiEndpoints {
    static func getArticles(with articleRequest: ArticleRequest) -> Endpoint<ArticleService> {
        return Endpoint(baseURL: "https://newsapi.org/v2/", path: "everything", method: .get, queryParameters: articleRequest)
    }
}
