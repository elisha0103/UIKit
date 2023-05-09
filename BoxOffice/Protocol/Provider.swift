//
//  Provider.swift
//  BoxOffice
//
//  Created by 진태영 on 2023/05/05.
//

import Foundation

// Provider에서 Endpoint 객체를 받으면 따로 Response 타입을 넘기지 않아도 되도록 설계

protocol Provider {
    func request<R: Decodable, E: RequestResponsable>(with endpoint: E, completion: @escaping (Result<R, Error>) -> Void) where E.Response == R
    func request(_ url: URL, completion: @escaping (Result<Data, Error>) -> ())
}

/*
 Provider에서 Request를 한다.
 하지만 Provider에서 Response의 타입을 알아야 해당 타입으로 Request를 할 수 있을 것이다.
 Provider 내부를 제네릭으로 구현한다고 해도, 제네릭에 특정 타입을 명시해줘야 Request를 할 수 있을 것이고
 이를 Endpoint 객체를 넘김으로 해결한다.
 */
