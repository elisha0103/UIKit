//
//  ArticleProject+.swift
//  ArticleProject
//
//  Created by 진태영 on 2023/05/22.
//

import Foundation

extension Bundle {
    var apiKey: String {
        guard let file = self.path(forResource: "ApiInfo", ofType: "plist") else { return "" }
        
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        
        guard let key = resource["API_KEY"] as? String else { fatalError("ApiInfo.plist에 API_KEY 설정을 해주세요.")}
        return apiKey
    }
}
