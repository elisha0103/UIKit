//
//  Channel.swift
//  ChatDemo
//
//  Created by 진태영 on 10/27/23.
//

import Foundation

import Firebase

struct Channel {
    let id: String?
    var toUserName: String
    let toUserId: String
    var recentDate: Date
    
    // create
    init(id: String? = nil, toUser: User) {
        self.id = id
        self.toUserName = toUser.fullName
        self.toUserId = toUser.uid
        self.recentDate = Date()
    }
    
    // subscribe
    init?(_ document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let toUserName = data["toUserName"] as? String,
              let recentDate = data["recentDate"] as? Timestamp,
              let toUserId = data["toUserId"] as? String else { return nil }
        
        self.recentDate = recentDate.dateValue()

        id = document.documentID
        self.toUserId = toUserId
        self.toUserName = toUserName
    }
}
