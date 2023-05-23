//
//  HeadlineArticleRequest.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/23.
//

import Foundation

struct HeadlineArticleRequest: Codable, ArticleRequestProtocol {
    let country: String?
    let page: Int // Page
    let apiKey: String = Bundle.main.apiKey // apiKey
    
    
    enum CodingKeys: String, CodingKey {
        case country = "country"
        case page = "page"
        case apiKey = "apiKey"
        
    }
}
