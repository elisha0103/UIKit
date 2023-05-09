//
//  URLSessionable.swift
//  BoxOffice
//
//  Created by 진태영 on 2023/05/05.
//

import Foundation

// 네트워크 테스트에 사용 할 URLSession 테스트 프로토콜 정의
protocol URLSessionable {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionable {}
