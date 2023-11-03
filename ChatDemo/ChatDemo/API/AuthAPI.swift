//
//  AuthAPI.swift
//  ChatDemo
//
//  Created by 진태영 on 11/3/23.
//

import Foundation

import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullName: String
}

struct AuthAPI {
    static let shared = AuthAPI()
    
    func logUserIn(withEmail email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(credentials: AuthCredentials, completion: @escaping(Error?) -> Void) {
        let email: String = credentials.email
        let password: String = credentials.password
        let fullName = credentials.fullName
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG ERROR:", #function, error.localizedDescription)
                return
            }
            
            guard let uid = result?.user.uid else { return }
            let values = [
                "email": email,
                "fullName": fullName,
            ]
            REF_USERS.document("\(uid)").setData(values, completion: completion)
        }
    }
}
