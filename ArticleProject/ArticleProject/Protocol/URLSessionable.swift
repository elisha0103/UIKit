//
//  URLSessionable.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/22.
//

import Foundation

protocol URLSessionable {
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    func dataTask(with url: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionable { }
