//
//  Friend.swift
//  MyFriends
//
//  Created by 진태영 on 2023/04/04.
//

import Foundation
/*
 {
     "name":"하나",
     "age":22,
     "address_info": {
         "country":"대한민국",
         "city":"울산"
     }

 */

struct APIResponse: Codable {
    let results: [Friend]
}

struct Friend:Codable {
    struct Name: Codable {
        let title: String
        let first: String
        let last: String
        
        var full: String {
            return self.title.capitalized + ". " + self.first.capitalized + " " + self.last.capitalized
        }
    }
    
    struct Picture: Codable {
        let large: String
        let medium: String
        let thumbnail: String
    }
    
    let name: Name
    let email: String
    let picture: Picture
}
