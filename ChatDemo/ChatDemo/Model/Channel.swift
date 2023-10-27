//
//  Channel.swift
//  ChatDemo
//
//  Created by 진태영 on 10/27/23.
//

import Foundation

struct Channel {
    var id: String?
    let name: String
    
    init(id: String? = nil, name: String) {
        self.id = id
        self.name = name
    }
}
