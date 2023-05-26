//
//  ArticleApiProvider.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/19.
//

import Foundation

class ArticleApiProvider: Provider {
    let session: URLSessionable
    
    init(session: URLSessionable = URLSession.shared) {
        self.session = session
    }
    
    // 제네릭 함수
    // R은 Decodable 해야하고, Endpoint 내 Response 타입과 일치해야한다.
    // E는 Endpoint 조건을 가지고 있어야한다.
    func request<R, E>(with endpoint: E, completion: @escaping (Result<R, Error>) -> Void) where R : Decodable, R == E.Response, E : RequestResponsable {
        do {
            print("func request")
            let urlRequest = try endpoint.getUrlRequest()
            print("urlRequest: \(String(describing: urlRequest.url?.absoluteString))")
            session.dataTask(with: urlRequest) { [weak self] data, response, error in
                self?.checkError(with: data, response, error, completion: { result in
                    guard let articleApiProvider = self else { return }
                    switch result {
                    case .success(let data):
                        // 요청된 데이터를 Endpoint Response 타입에 따라 decode 하는 부분
                        completion(articleApiProvider.decode(data: data))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                })
            }
            .resume()
        } catch {
            print("request가 실패요")
            completion(.failure(NetworkError.urlRequestError(error)))
        }
    }
    
    func request(_ url: URL, completion: @escaping (Result<Data, Error>) -> ()) {
        session.dataTask(with: url) { [weak self] data, response, error in
            self?.checkError(with: data, response, error, completion: { result in
                completion(result)
            })
        }
        .resume()
    }
    
    private func checkError(with data: Data?, _ response: URLResponse?, _ error: Error?, completion: @escaping (Result<Data, Error>) -> ()) {
        let nomalNetworkResponseCodes: ClosedRange<Int> = 200...299
        print("func checkError")
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let response = response as? HTTPURLResponse else { completion(.failure(NetworkError.unknownError))
            return
        }
        
        guard nomalNetworkResponseCodes.contains(response.statusCode) else {
            completion(.failure(NetworkError.serverError(ServerError(rawValue: response.statusCode) ?? .unknown)))
            return
        }
        
        guard let data = data else {
            completion(.failure(NetworkError.emptyData))
            return
        }
        
        completion(.success(data))
        
    }
    
    private func decode<T: Decodable>(data: Data) -> Result<T, Error> {
        print("func decode")
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return .success(decoded)
        } catch {
            return .failure(NetworkError.emptyData)
        }
    }
}
