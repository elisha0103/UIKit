//
//  Articles.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/11.
//

import Foundation

struct ArticleService: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]?
}
