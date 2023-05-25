//
//  MockURLSession.swift
//  ArticleProjectTests
//
//  Created by 진태영 on 2023/05/25.
//

import Foundation
@testable import ArticleProject

class MockURLSession: URLSessionable {
    
    
    var makeRequestFail: Bool
    var sessionDataTask: MockURLSessionDataTask?
    
    init(makeRequestFail: Bool, sessionDataTask: MockURLSessionDataTask? = nil) {
        self.makeRequestFail = makeRequestFail
        self.sessionDataTask = sessionDataTask
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        let endPoint = ApiEndpoints.getArticles(with: ArticleRequest(q: "", page: 1))
        
        // 성공 callback
        let successResponse = HTTPURLResponse(url: try! endPoint.makeUrl(),
                                              statusCode: 200,
                                              httpVersion: "2",
                                              headerFields: nil)
        // 실패 callback
        let failureResponse = HTTPURLResponse(url: try! endPoint.makeUrl(),
                                              statusCode: 401,
                                              httpVersion: "2",
                                              headerFields: nil)

        let sessionDataTask: MockURLSessionDataTask = MockURLSessionDataTask()

        // sessionDataTask의 resumeDidCall에 makeRequestFail 값에 따라 달라지는 completionHandler를 할당함
        // resume() 이 호출되면 completionHandler()가 호출
        
        sessionDataTask.resumeDidCall = {
            if self.makeRequestFail {
                completionHandler(nil, failureResponse, nil)
            } else {
                completionHandler(endPoint.sampleData!, successResponse, nil)
            }
        }
        self.sessionDataTask = sessionDataTask
        return sessionDataTask
    }

    
    func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        let endPoint = ApiEndpoints.getArticlesImage(path: "https://s.yimg.com/uu/api/res/1.2/LKRH31mzL9wqtcqoQ_lkjw--~B/Zmk9ZmlsbDtoPTYzMDtweW9mZj0wO3c9MTIwMDthcHBpZD15dGFjaHlvbg--/https://media-mbst-pub-ue1.s3.amazonaws.com/creatr-uploaded-images/2023-04/835a5670-e5f4-11ed-9db6-3febf57b7a4a.cf.jpg", width: 1)
        
        let successResponse = HTTPURLResponse(url: try! endPoint.makeUrl(),
                                              statusCode: 200,
                                              httpVersion: "2",
                                              headerFields: nil)
        // 실패 callback
        let failureResponse = HTTPURLResponse(url: try! endPoint.makeUrl(),
                                              statusCode: 401,
                                              httpVersion: "2",
                                              headerFields: nil)

        let sessionDataTask: MockURLSessionDataTask = MockURLSessionDataTask()

        // sessionDataTask의 resumeDidCall에 makeRequestFail 값에 따라 달라지는 completionHandler를 할당함
        // resume() 이 호출되면 completionHandler()가 호출
        
        sessionDataTask.resumeDidCall = {
            if self.makeRequestFail {
                completionHandler(nil, failureResponse, nil)
            } else {
                completionHandler(endPoint.sampleData!, successResponse, nil)
            }
        }
        self.sessionDataTask = sessionDataTask
        return sessionDataTask

    }
    
    
}
