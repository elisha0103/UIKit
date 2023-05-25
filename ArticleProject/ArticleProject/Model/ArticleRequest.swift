//
//  ArticleRequest.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/19.
//

import Foundation

struct ArticleRequest: Codable, ArticleRequestProtocol {
    let q: String // 검색어
    let page: Int // Page
    let apiKey: String = Bundle.main.apiKey // apiKey
    
    
    enum CodingKeys: String, CodingKey {
        case q = "q"
        case page = "page"
        case apiKey = "apiKey"
        
    }
    init(q: String, page: Int) {
        self.q = q
        self.page = page
    }
}
