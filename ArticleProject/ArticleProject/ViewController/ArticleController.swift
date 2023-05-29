//
//  ArticleController.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/11.
//

import Foundation

class ArticleController {
    var delegate: ArticleProtocol?
    var request: ArticleRequestProtocol?
    let articleApiProvider: ArticleApiProvider = ArticleApiProvider()
    
    func getArticles() {
        delegate?.articlesRetrieved(articles: [])
        guard let articleRequest = self.request else { return }
        
        articleApiProvider.request(with: ApiEndpoints.getArticles(with: articleRequest)) { result in
            switch result {
            case .success(let articleService):
                DispatchQueue.main.async {
                    self.delegate?.articlesRetrieved(articles: articleService.articles ?? [])
                }
                break
                
            case .failure(let error):
                print("ArticleController func getArticles Error: \(error.localizedDescription)")
                break
                
            }
        }
    }
}
