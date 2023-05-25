//
//  URLSessionDataTaskProtocol.swift
//  ArticleProjectTests
//
//  Created by 진태영 on 2023/05/25.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }
