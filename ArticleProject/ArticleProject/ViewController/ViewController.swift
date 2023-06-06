//
//  ViewController.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/10.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ArticleTableViewCell = tableView.dequeueReusableCell(withIdentifier: articleCellIdentifier, for: indexPath) as? ArticleTableViewCell ?? ArticleTableViewCell(style: .default, reuseIdentifier: articleCellIdentifier)
        let article = self.articles[indexPath.row]
        
        cell.displayArticle(article: article, forIndexPath: indexPath, tableView: tableView)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    

    var model = ArticleController()
    var articles: [Article] = []
    let articleCellIdentifier: String = "ArticleCell"
    let refreshControl = UIRefreshControl()
    var searchText: String?
    var page: Int?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ArticleController의 getArticles 함수로 가져온 데이터를 사용하기 위해서 delegate를 사용함
        // model에서 사용하는 함수를 self를 통해 ViewController가 관장하고 있으므로 데이터도 비동기적으로 가져올 수 있음
        // model의 delegate는 ArticleProtocol을 따르는 객체이다. 따라서 self가 관장하기 위해서 self도 해당 프로토콜을 따라야한다.
        model.delegate = self
        model.request = HeadlineArticleRequest(country: "US", page: 1)
        model.getArticles()
        /*
         model의 getArticles 함수는 내부에 delegate.articleRetrieved() 구문이 있다.
         아직 articleRetrieved의 함수를 정의해주지 않았는데, model.delegate를 self가 관장하고 있고 delegate는 ArticleProtocol을 따르므로 해당 프로토콜의 함수 정의도
         self가 해줘야한다. 따라서 extension에 해당 프로토콜 함수를 정의했다.
         */
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPathForSelectedRow
        
        guard let indexPath = indexPath else { return }
        
        let selectedArticle = articles[indexPath.row]
        
        let detailVC = segue.destination as? DetailViewController
        detailVC?.url = selectedArticle.url
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchText = searchBar.text
        guard let searchText = searchText else { return }
        let articleRequest: ArticleRequest = ArticleRequest(q: "\(searchText)", page: 1)
        model.delegate = self
        model.request = articleRequest
        model.getArticles()
    }
    
    func initRefresh() {
        refreshControl.addTarget(self, action: #selector(refreshTable(refresh: )), for: .valueChanged)
        
        tableView.refreshControl = self.refreshControl
    }
    
    @objc func refreshTable(refresh: UIRefreshControl) {
        print("새로고침")
        guard let searchText = self.searchText else { return }
        let articleRequest: ArticleRequest = ArticleRequest(q: "\(searchText)", page: 1)
        model.delegate = self
        model.request = articleRequest
        model.getArticles()
        
    }

    

}

