//
//  Provider.swift
//  BoxOffice
//
//  Created by 진태영 on 2023/05/05.
//

import Foundation

protocol Provider {
    func request<R: Decodable, E: RequestResponsable>(with endpoint: E, completion: @escaping (Result<R, Error>) -> Void) where E.Response == R
    func request(_ url: URL, completion: @escaping (Result<Data, Error>) -> ())
}
