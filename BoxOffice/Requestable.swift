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
        
        guard let bodyParameters = try bodyParameters?.toDictionary() else { throw NetworkError.toDictionaryError }
        if !bodyParameters.isEmpty {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters)
        }
        
        headers?.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: "\(key)")
        }
        
        return urlRequest
    }
    
    func makeUrl() throws -> URL {
        let fullPath = "\(baseURL)\(path)"
        guard var urlComponents = URLComponents(string: fullPath) else { throw NetworkError.componentsError }
        
        var urlQueryItems: [URLQueryItem] = []
        guard let queryParameters = try queryParameters?.toDictionary() else { throw NetworkError.toDictionaryError }
            queryParameters.forEach { key, value in
                urlQueryItems.append(URLQueryItem(name: key, value: "\(value)"))
            }
        
        urlComponents.queryItems = urlQueryItems.isEmpty ? nil : urlQueryItems
        guard let url = urlComponents.url else { throw NetworkError.componentsError }
        return url
    }
}
