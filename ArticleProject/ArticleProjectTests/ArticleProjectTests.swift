//
//  ArticleProjectTests.swift
//  ArticleProjectTests
//
//  Created by 진태영 on 2023/05/25.
//

import XCTest
@testable import ArticleProject

final class ArticleProjectTests: XCTestCase {
    
    var sut: ArticleApiProvider?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ArticleApiProvider(session: MockURLSession(makeRequestFail: false))
    }
    
    func testFetchArticleListWhenSuccess() {
        sut = ArticleApiProvider(session: MockURLSession(makeRequestFail: false))

        // async테스트를 위해서 XCTestExpectation 사용
        let expectation = XCTestExpectation()
        
        let endpoint = ApiEndpoints.getArticles(with: ArticleRequest(q: "bitcoin", page: 1))
        
        guard let sampleData: Data = NetworkMock.load() else {
            print("sampleData가 없습니다.")
            return
        }

        let responseMock = try? JSONDecoder().decode(ArticleService.self, from: sampleData)
        sut?.request(with: endpoint, completion: { result in
            switch result {
            case .success(let response):
                print("***TEST***\n테스트 성공\n**********")
                XCTAssertEqual(response.articles?.first?.title, responseMock?.articles?.first?.title)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 2.0)
        
    }
    
    func testFetchArticleListWhenFail() {
        sut = ArticleApiProvider(session: MockURLSession(makeRequestFail: true))
        // async테스트를 위해서 XCTestExpectation 사용
        let expectation = XCTestExpectation()
        
        let endpoint = ApiEndpoints.getArticles(with: ArticleRequest(q: "bitcoin", page: 1))

        sut?.request(with: endpoint, completion: { result in
            switch result {
            case .success(_):
                XCTFail()

            case .failure(let error):
                print("***TEST***\nError: \(error.localizedDescription)\n**********")
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 2.0)
        
    }
    
    func testArticleImageWhenSuccess() {
        sut = ArticleApiProvider(session: MockURLSession(makeRequestFail: false))

        let expectation = XCTestExpectation()
        
        let urlString: String = "https://s.yimg.com/uu/api/res/1.2/LKRH31mzL9wqtcqoQ_lkjw--~B/Zmk9ZmlsbDtoPTYzMDtweW9mZj0wO3c9MTIwMDthcHBpZD15dGFjaHlvbg--/https://media-mbst-pub-ue1.s3.amazonaws.com/creatr-uploaded-images/2023-04/835a5670-e5f4-11ed-9db6-3febf57b7a4a.cf.jpg"
//        let endPoint = ApiEndpoints.getArticlesImage(path: "https://s.yimg.com/uu/api/res/1.2/LKRH31mzL9wqtcqoQ_lkjw--~B/Zmk9ZmlsbDtoPTYzMDtweW9mZj0wO3c9MTIwMDthcHBpZD15dGFjaHlvbg--/https://media-mbst-pub-ue1.s3.amazonaws.com/creatr-uploaded-images/2023-04/835a5670-e5f4-11ed-9db6-3febf57b7a4a.cf.jpg", width: 1)
//        let responseMock = UIImage(data: endPoint.sampleData!)
        
        guard let url: URL = URL(string: urlString) else {
            XCTFail("URL 변환에 실패")
            return
        }
        
        sut?.request(url, completion: { result in
            switch result {
            case .success(let data):
                print("request 성공: \(data.description)")
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()

        })
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testArticleImageWhenFail() {
        sut = ArticleApiProvider(session: MockURLSession(makeRequestFail: true))
        let expectation = XCTestExpectation()
        
        let urlString: String = "https://s.yimg.com/uu/api/res/1.2/LKRH31mzL9wqtcqoQ_lkjw--~B/Zmk9ZmlsbDtoPTYzMDtweW9mZj0wO3c9MTIwMDthcHBpZD15dGFjaHlvbg--/https://media-mbst-pub-ue1.s3.amazonaws.com/creatr-uploaded-images/2023-04/835a5670-e5f4-11ed-9db6-3febf57b7a4a.cf.jpg"
//        let endPoint = ApiEndpoints.getArticlesImage(path: "https://s.yimg.com/uu/api/res/1.2/LKRH31mzL9wqtcqoQ_lkjw--~B/Zmk9ZmlsbDtoPTYzMDtweW9mZj0wO3c9MTIwMDthcHBpZD15dGFjaHlvbg--/https://media-mbst-pub-ue1.s3.amazonaws.com/creatr-uploaded-images/2023-04/835a5670-e5f4-11ed-9db6-3febf57b7a4a.cf.jpg", width: 1)
//        let responseMock = UIImage(data: endPoint.sampleData!)
        
        guard let url: URL = URL(string: urlString) else {
            XCTFail("URL 변환에 실패")
            return
        }

        sut?.request(url, completion: { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                print("request 실패 정상 작동: \(error.localizedDescription)")
                break
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 2.0)
    }
    
}
