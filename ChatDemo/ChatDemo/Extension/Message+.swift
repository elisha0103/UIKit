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
