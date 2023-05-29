//
//  Requestable+.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/19.
//

import Foundation

extension Requestable {
    func getUrlRequest() throws -> URLRequest {
        let url = try makeUrl()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        if bodyParameters != nil {
            guard let bodyParameters = try bodyParameters?.toDictionary() else { throw NetworkError.toDictionaryError }
            if !bodyParameters.isEmpty {
                // 딕셔너리 타입의 변수를 JSON 파일로 변경
                // JSON 파일을 httpbody에 넣어줌으로써 서버에 전송할 데이터 삽입
                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters)
            }
        }
        
        if headers != nil {
            headers?.forEach({ key, value in
                urlRequest.setValue(value, forHTTPHeaderField: "\(key)")
            })
        }
        return urlRequest
    }
    
    func makeUrl() throws -> URL {
        let fullPath = "\(baseURL)\(String(describing: path))"
        guard var urlComponents = URLComponents(string: fullPath) else { throw NetworkError.componentsError }
        
        var urlQueryItems: [URLQueryItem] = []
        // Encodable 타입 변수를 딕셔너리 형태로 변환
        guard let queryParameters = try queryParameters?.toDictionary() else { throw NetworkError.toDictionaryError }
        
        //딕셔너리 queryParameters를 하나씩 꺼내어 urlQueryItems에 추가
        queryParameters.forEach { key, value in
            urlQueryItems.append(URLQueryItem(name: key, value: "\(value)"))
        }
        
        urlComponents.queryItems = urlQueryItems.isEmpty ? nil : urlQueryItems
        guard let url = urlComponents.url else { throw NetworkError.componentsError }
        print("complete url: \(url.absoluteString)")
        return url
    }
}
