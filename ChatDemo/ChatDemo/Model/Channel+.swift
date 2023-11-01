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
        return lhs.name < rhs.name
    }
}

extension Channel: DatabaseRepresentation {
    var representation: [String : Any] {
        var rep = ["name": name]
        
        if let id = id {
            rep["id"] = id
        }
        
        return rep
    }
}
