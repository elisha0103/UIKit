//
//  MoviesAPIProvider.swift
//  BoxOffice
//
//  Created by 진태영 on 2023/05/05.
//

import Foundation

class MoviesAPIProvider: Provider {
    let session: URLSessionable
    
    init(session: URLSessionable = URLSession.shared) {
        self.session = session
    }
    
    func request<R, E>(with endpoint: E, completion: @escaping (Result<R, Error>) -> Void) where R : Decodable, R == E.Response, E : RequestResponsable {
        do {
            let urlRequest = try endpoint.getUrlRequest()
            
            session.dataTask(with: urlRequest) { [weak self] data, response, error in
                self?.checkError(with: data, response, error) { result in
                    guard let moviesAPIProvider = self else { return }
                
                    switch result {
                    case .success(let data):
                        completion(moviesAPIProvider.decode(data: data))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
            .resume()
        } catch {
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
        
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let response = response as? HTTPURLResponse else {
            completion(.failure(NetworkError.unknownError))
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
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return .success(decoded)
        } catch {
            return .failure(NetworkError.emptyData)
        }
    }
    
}
