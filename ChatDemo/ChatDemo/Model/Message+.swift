//
//  Message+.swift
//  ChatDemo
//
//  Created by 진태영 on 10/27/23.
//

import Foundation

extension Message: Comparable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: Message, rhs: Message) -> Bool {
        return lhs.sentDate < rhs.sentDate
    }
}

extension Message: DatabaseRepresentation {
    var representation: [String : Any] {
        var representation: [String: Any] = [
            "created": sentDate,
            "senderId": sender.senderId,
            "senderName": sender.displayName
        ]
        
        if let url = downloadURL {
            representation["url"] = url.absoluteString
        } else {
            representation["content"] = content
        }
        
        return representation
    }
}
