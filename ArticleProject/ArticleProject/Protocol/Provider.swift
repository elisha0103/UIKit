//
//  Provider.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/19.
//

import Foundation
// Provider에서 Endpoint 객체를 받으면 따로 Repsonse 타입을 넘기지 않아도 되도록 설계

protocol Provider {
    // 특정 Responsable이 존재하는 Request
    // Endcode 할 수 있는 타입을 전달해줘서 해당 타입과 동일한 객체를 서버로부터 얻고자 하는 경우
    func request<R: Decodable, E: RequestResponsable>(with endpoint: E, completion: @escaping (Result<R, Error>) -> Void) where E.Response == R
    
    // data를 얻는 Request -> 단순하게 특정 타입을 위한 함수
    func request(_ url: URL, completion: @escaping (Result<Data, Error>) -> ())
}

/*
 Provider에서 Request를 한다.
 하지만 Porivder에서 Response의 타입을 알아야 해당 타입으로 Request 할 수 있을 것이ㅏㄷ.
 Porivder 내부를 제네릭으로 구현한다고 해도, 제네릭에 특정 타입을 명시해줘야 Request를 할 수 있을 것이고 이를 Endpoint 객체로 넘김으로 해결한다.
 */
