//
//  NetworkEndpoint.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/19.
//

import Foundation

class Endpoint<R>: RequestResponsable {
    typealias Response = R
    var baseURL: String
    var path: String
    var method: HttpMethod
    var queryParameters: Encodable?
    var bodyParameters: Encodable?
    var headers: [String: String]?
    var sampleData: Data?
    init(baseURL: String, path: String, method: HttpMethod, queryParameters: Encodable? = nil, bodyParameters: Encodable? = nil, headers: [String : String]? = nil, sampleData: Data? = nil) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.queryParameters = queryParameters
        self.bodyParameters = bodyParameters
        self.headers = headers
        self.sampleData = sampleData
    }

}
