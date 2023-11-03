//
//  ChannelNotiManager.swift
//  ChatDemo
//
//  Created by 진태영 on 11/3/23.
//

import Foundation

class ChannelNotiManager {
    static let shared = ChannelNotiManager()
    
    var currentChatRoomId: String?
    
    private init() { }
    
}
