//
//  NetworkEndPoint.swift
//  BoxOffice
//
//  Created by 진태영 on 2023/05/05.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol Requestable {
    var baseURL: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var queryParameters: Encodable? { get }
    var bodyParameters: Encodable? { get }
    var headers: [String: String]? { get }
    var sampleData: Data? { get }
}

extension Requestable {
    func getUrlRequest() throws -> URLRequest {
        let url = try makeUrl()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        // 서버에 전달할 데이터 / 서버에 전달할 객체를 JSON으로 변경 후 딕셔너리 타입으로 변환
        guard let bodyParameters = try bodyParameters?.toDictionary() else { throw NetworkError.toDictionaryError }
        if !bodyParameters.isEmpty {
            // 딕셔너리 타입의 변수를 JSON 파일로 변경
            // JSON 파일을 httpbody에 넣어줌으로써 서버에 전송할 데이터 삽입
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters)
        }

        headers?.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: "\(key)")
        }
        
        return urlRequest
    }
    
    // Requestable 파라미터로 URL을 구성하여 반환하는 함수
    func makeUrl() throws -> URL {
        let fullPath = "\(baseURL)\(path)"
        guard var urlComponents = URLComponents(string: fullPath) else { throw NetworkError.componentsError }
        
        var urlQueryItems: [URLQueryItem] = []
        // Encodable 타입 변수를 딕셔너리 형태로 변환
        guard let queryParameters = try queryParameters?.toDictionary() else { throw NetworkError.toDictionaryError }
        
        // 딕셔너리 queryParameters를 하나씩 꺼내어 urlQueryItems에 추가
        queryParameters.forEach { key, value in
            urlQueryItems.append(URLQueryItem(name: key, value: "\(value)"))
        }
        
        urlComponents.queryItems = urlQueryItems.isEmpty ? nil : urlQueryItems
        guard let url = urlComponents.url else { throw NetworkError.componentsError }
        return url
    }
}
