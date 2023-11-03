//
//  Message.swift
//  ChatDemo
//
//  Created by 진태영 on 10/27/23.
//

import UIKit

import MessageKit
import Firebase

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
    
    init(user: User, content: String) {
        sender = Sender(senderId: user.uid, displayName: user.fullName)
        self.content = content
        sentDate = Date()
        id = nil
    }
    
    init(user: User, image: UIImage) {
        sender = Sender(senderId: user.uid, displayName: UserDefaultManager.displayName)
        self.image = image
        sentDate = Date()
        content = ""
        id = nil
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let sentDate = data["created"] as? Timestamp,
              let senderId = data["senderId"] as? String,
              let senderName = data["senderName"] as? String else { return nil }
        id = document.documentID
        self.sentDate = sentDate.dateValue()
        sender = Sender(senderId: senderId, displayName: senderName)
        
        if let content = data["content"] as? String {
            self.content = content
            downloadURL = nil
        } else if let urlString = data["url"] as? String, let url = URL(string: urlString) {
            downloadURL = url
            content = ""
        } else {
            return nil
        }
    }
}
