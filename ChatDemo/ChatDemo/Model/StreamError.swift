//
//  StreamError.swift
//  ChatDemo
//
//  Created by 진태영 on 11/1/23.
//

import Foundation

enum StreamError: Error {
    case firestoreError(Error?)
    case decodedError(Error?)
}
