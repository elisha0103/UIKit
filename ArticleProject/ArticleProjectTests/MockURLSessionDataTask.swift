//
//  MockURLSessionDataTask.swift
//  ArticleProjectTests
//
//  Created by 진태영 on 2023/05/25.
//

import Foundation
@testable import ArticleProject

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    
    var resumeDidCall: (() -> ())?
        
    init(resumeDidCall: ( () -> Void)? = nil) {
        self.resumeDidCall = resumeDidCall
    }
    
    func resume() {
        resumeDidCall?()
    }
}
