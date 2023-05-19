//
//  ArticleController.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/11.
//

import Foundation

class ArticleController {
    var delegate: ArticleProtocol?
    
    func getArticles() {
        delegate?.articlesRetrieved(articles: [])
    }
}
