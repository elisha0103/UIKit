//
//  Encodable+.swift
//  ChatDemo
//
//  Created by 진태영 on 11/1/23.
//

import Foundation

extension Encodable {
    // Object to Dictionary
    // ex: Struct to [String: Any] (JSON)
    var asDictionary: [String: Any]? {
        guard let object = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: object, options: [])
                as? [String: Any] else { return nil }
        return dictionary
    }
}
