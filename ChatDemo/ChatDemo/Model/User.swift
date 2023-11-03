//
//  User.swift
//  ChatDemo
//
//  Created by 진태영 on 11/3/23.
//

import Foundation

struct User {
    let uid: String
    let email: String
    var fullName: String
    var fcmToken: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        
        self.email = dictionary["email"] as? String ?? ""
        self.fullName = dictionary["fullName"] as? String ?? ""
        self.fcmToken = dictionary["fcmToken"] as? String ?? ""
    }
}
