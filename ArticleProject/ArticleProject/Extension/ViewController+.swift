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
        // 처음 불러오는 경우 -> self.articles = articles, 처음이 아닌 경우 일단 기존 배열에 추가
        self.page == 1 ? self.articles = articles : self.articles.append(contentsOf: articles)
        // 처음이 아닌경우, 페이지 끝 데이터가 아닌 경우 계속 추가, 페이지 끝 데이터인 경우 빈배열만 추가하고 다음 호출 중지
        (self.page != 1 && articles.isEmpty) ? (self.isPaginationFetching = false) : (self.isPaginationFetching = true)
        self.tableView.reloadData()
    }
}
