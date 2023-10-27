//
//  Message.swift
//  ChatDemo
//
//  Created by 진태영 on 10/27/23.
//

import UIKit
import Foundation
import MessageKit

struct Message: MessageType {
    let id: String?
    let sender: SenderType
    var messageId: String {
        return id ?? UUID().uuidString
    }
    let content: String
    var image: UIImage?
    var downloadURL: URL?
    var sentDate: Date
    var kind: MessageKit.MessageKind {
        if let image = image {
            let mediaItem = ImageMediaItem(image: image)
            return .photo(mediaItem)
        } else {
            return .text(content)
        }
    }
    
    init(content: String) {
        sender = Sender(senderId: "id(TODO...)", displayName: "displayName(TODO...)")
        self.content = content
        sentDate = Date()
        id = nil
    }
    
    init(image: UIImage) {
        sender = Sender(senderId: "id(TODO...)", displayName: "displayName(TODO...)")
        self.image = image
        sentDate = Date()
        content = ""
        id = nil
    }
    
    
}
