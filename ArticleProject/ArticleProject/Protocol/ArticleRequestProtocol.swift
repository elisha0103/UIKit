//
//  ArticleRequestProtocol.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/23.
//

import Foundation

protocol ArticleRequestProtocol: Codable {
    var apiKey: String { get }
}
