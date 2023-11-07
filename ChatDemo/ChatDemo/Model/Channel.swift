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
    var previewContent: String
    var alarmNumber: Int
    var representation: [String : Any] {
        let rep = [
            "toUserId": toUserId,
            "toUserName": toUserName,
            "recentDate": recentDate
        ] as [String : Any]
                
        return rep
    }

    // create
    init(id: String? = nil, toUser: User) {
        self.id = id
        self.toUserName = toUser.fullName
        self.toUserId = toUser.uid
        self.recentDate = Date()
        self.previewContent = ""
        self.alarmNumber = 0
    }
    
    // subscribe
    init?(_ document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let toUserName = data["toUserName"] as? String,
              let recentDate = data["recentDate"] as? Timestamp,
              let toUserId = data["toUserId"] as? String,
              let previewContent = data["previewContent"] as? String,
              let alarmNumber = data["alarmNumber"] as? Int else { return nil }
        
        self.recentDate = recentDate.dateValue()
        
        id = document.documentID
        self.toUserId = toUserId
        self.toUserName = toUserName
        self.previewContent = previewContent
        self.alarmNumber = alarmNumber
    }
}
