//
//  APIEndpoints.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/19.
//

import Foundation

struct ApiEndpoints {
    static func getArticles(with articleRequest: ArticleRequestProtocol) -> Endpoint<ArticleService> {
        
        if ((articleRequest as? ArticleRequest) != nil) {
            print("Endpoint, everything")
            return Endpoint(baseURL: "https://newsapi.org/v2/", path: "everything", method: .get, queryParameters: articleRequest, sampleData: NetworkMock.articleList)
        } else {
            print("Endpoint, top-headlines")
            return Endpoint(baseURL: "https://newsapi.org/v2/", path: "top-headlines", method: .get, queryParameters: articleRequest, sampleData: NetworkMock.articleList)
        }
    }
    
    static func getArticlesImage(path: String, width: Int) -> Endpoint<Data> {
//        let sizes = [92, 154, 185, 342, 500, 780]
//        let closesWidth = sizes.enumerated().min { abs($0.1 - width) < abs($1.1 - width)}?.element ?? sizes.first
        
        return Endpoint(baseURL: path, path: "", method: .get, sampleData: NetworkMock.image)
    }
}
