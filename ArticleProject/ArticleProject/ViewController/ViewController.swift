//
//  ViewController.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/10.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIScrollViewDelegate {
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
    var isPaginationFetching: Bool = true
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ArticleController의 getArticles 함수로 가져온 데이터를 사용하기 위해서 delegate를 사용함
        // model에서 사용하는 함수를 self를 통해 ViewController가 관장하고 있으므로 데이터도 비동기적으로 가져올 수 있음
        // model의 delegate는 ArticleProtocol을 따르는 객체이다. 따라서 self가 관장하기 위해서 self도 해당 프로토콜을 따라야한다.
        self.page = 1
        
        let headlineArticleRequest: HeadlineArticleRequest = HeadlineArticleRequest(country: "kr", page: page ?? 1)
        model.delegate = self
        getArticleResponse(request: headlineArticleRequest)

        /*
         model의 getArticles 함수는 내부에 delegate.articleRetrieved() 구문이 있다.
         아직 articleRetrieved의 함수를 정의해주지 않았는데, model.delegate를 self가 관장하고 있고 delegate는 ArticleProtocol을 따르므로 해당 프로토콜의 함수 정의도
         self가 해줘야한다. 따라서 extension에 해당 프로토콜 함수를 정의했다.
         */
        initRefresh()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPathForSelectedRow
        
        guard let indexPath = indexPath else { return }
        
        let selectedArticle = articles[indexPath.row]
        
        let detailVC = segue.destination as? DetailViewController
        detailVC?.url = selectedArticle.url
    }
    
    func getArticleResponse(request: ArticleRequestProtocol) {
        print("page: \(page)")
        model.request = request
        model.getArticles()
        guard self.page != nil else { return }
        self.page! += 1
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchText = searchBar.text
        guard let searchText = searchText else { return }
        self.page = 1
        self.isPaginationFetching = true
        let articleRequest: ArticleRequest = ArticleRequest(q: "\(searchText)", page: page ?? 1)
        getArticleResponse(request: articleRequest)
        
    }
    
    func initRefresh() {
        refreshControl.addTarget(self, action: #selector(refreshTable(refresh: )), for: .valueChanged)
        
        tableView.refreshControl = self.refreshControl
    }
    
    @objc func refreshTable(refresh: UIRefreshControl) {
        print("page 새로고침")
        self.page = 1
        self.isPaginationFetching = true
        
        if let searchText = self.searchText {
            let articleRequest: ArticleRequest = ArticleRequest(q: "\(searchText)", page: page ?? 1)

            getArticleResponse(request: articleRequest)
            refresh.endRefreshing()
            
            return
        }
        
        let headlineArticleRequest: HeadlineArticleRequest = HeadlineArticleRequest(country: "kr", page: page ?? 1)
        getArticleResponse(request: headlineArticleRequest)
        refresh.endRefreshing()
        print("page 새로고침 끝")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset_y = tableView.contentOffset.y
        let tableViewContentSize = tableView.contentSize.height
        
        // contentOffset_y > 0은 refresh할 때에는 중복된 패치가 이뤄지지 않도록 하기 위함
        // 아래 구문은 아래로 스크롤할 때에만 적용되게 하기 위한 예외처리
        if contentOffset_y > (tableViewContentSize - tableView.bounds.size.height), isPaginationFetching, contentOffset_y > 0 {
            print("contentOffset_y: \(contentOffset_y)")
            print("second paramiters: \(tableViewContentSize - tableView.bounds.size.height)")
            print("-------Scroll-------")
            print("page plus")
            if let searchText = self.searchText {
                let articleRequest: ArticleRequest = ArticleRequest(q: "\(searchText)", page: page ?? 1)
                getArticleResponse(request: articleRequest)
                
                return
            }
            
            let headlineArticleReqeust: HeadlineArticleRequest = HeadlineArticleRequest(country: "kr", page: page ?? 1)
            getArticleResponse(request: headlineArticleReqeust)
            print("page scroll")
            
            return
        }
    }
    
    
}

