//
//  User.swift
//  SignUp
//
//  Created by 진태영 on 2023/03/22.
//

import Foundation

class User {
    
    static let shared: User = User()
    var id: String?
    var pw: String?
    var phoneNumber: String?
    var birthDay: String?
    var introduceMemo: String?
    
}
