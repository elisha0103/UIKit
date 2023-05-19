//
//  Responsable.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/19.
//

import Foundation

protocol Responsable {
    associatedtype Response // Protocol에서 제너릭 타입을 명시하는 방법
}

protocol RequestResponsable: Requestable, Responsable {}
