//
//  Channel+.swift
//  ChatDemo
//
//  Created by 진태영 on 10/27/23.
//

import Foundation

extension Channel: Comparable {
    static func == (lhs: Channel, rhs: Channel) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: Channel, rhs: Channel) -> Bool {
        return lhs.recentDate > rhs.recentDate
    }
}

extension Channel: DatabaseRepresentation {
}
