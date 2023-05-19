//
//  APIEndpoints.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/19.
//

import Foundation

struct ApiEndpoints {
    static func getArticles() -> Endpoint<ArticleService> {
        return Endpoint(baseURL: "", path: "", method: .get, queryParameters: "")
    }
}
