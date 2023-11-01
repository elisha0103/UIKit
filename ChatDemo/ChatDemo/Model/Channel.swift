//
//  Channel.swift
//  ChatDemo
//
//  Created by 진태영 on 10/27/23.
//

import Foundation

import Firebase

struct Channel {
    var id: String?
    let name: String
    
    init(id: String? = nil, name: String) {
        self.id = id
        self.name = name
    }
    
    init?(_ document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let name = data["name"] as? String else { return nil }
        
        id = document.documentID
        self.name = name
    }
}
