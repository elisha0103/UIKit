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

struct Friend:Codable {
    struct Address: Codable {
        let country: String
        let city: String
    }
    let name: String
    let age: Int
    let addressInfo: Address
    
    var nameAndage: String {
        return self.name + "(\(self.age))"
    }
    
    var fullAddress: String {
        return self.addressInfo.country + " / " + self.addressInfo.city
    }
    
    enum CodingKeys: String, CodingKey {
        case name, age
        case addressInfo = "address_info"
    }
}

var count: [Character] = []

var temp: Character = Character("")


count.removelast
