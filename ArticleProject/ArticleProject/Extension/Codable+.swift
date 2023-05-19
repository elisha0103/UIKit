//
//  Codable+.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/19.
//

import Foundation

extension Encodable {
    // 특정 객체를 JSON 형태의 데이터로 변환 후 이를 딕셔너리 형태로 반환하는 함수
    func toDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        // JSONSerialization: json -> array or dictionary / array or dictionary -> json parsing
        // jsonObject: json -> array or dictionary parsing function
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { throw NSError() }
        return dictionary
    }
}
