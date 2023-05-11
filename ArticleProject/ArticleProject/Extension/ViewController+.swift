//
//  ViewController+.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/11.
//

import Foundation

extension ViewController: ArticleProtocol {
    func articlesRetrieved(articles: [Article]) {
        print("articles retrieved from article model!")
    }
}
