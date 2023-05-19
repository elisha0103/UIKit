//
//  NetworkErrortype.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/19.
//

import Foundation

enum NetworkError: Error {
    case unknownError
    case componentsError
    case urlRequestError(Error)
    case serverError(ServerError)
    case emptyData
    case parsingError
    case decodingError(Error)
    case toDictionaryError
    
    var errorDescription: String {
        switch self {
        case .unknownError:
            return "알 수 없는 에러입니다."
        case .urlRequestError:
            return "URL Request 관련 에러가 발생했습니다."
        case .componentsError:
            return "URL components 관련 에러가 발생했습니다."
        case .serverError(let serverError):
            return "Status 코드 에러입니다. \(serverError) Code: \(serverError.rawValue)"
        case .emptyData:
            return "데이터가 없습니다."
        case .parsingError:
            return "데이터 Parsing 중 에러가 발생했습니다."
        case .decodingError:
            return "Decoding 에러가 발생했습니다."
        case .toDictionaryError:
            return "객체를 Dictionary 변환하는데 에러가 발생했습니다."
        }
    }
}

// RESTful API 에러 타입 정의
enum ServerError: Int {
    case unknown
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case unsplashError = 500
    case unsplashError2 = 503
}
