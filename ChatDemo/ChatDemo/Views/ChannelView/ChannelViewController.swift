//
//  ChannelViewController.swift
//  ChatDemo
//
//  Created by 진태영 on 10/27/23.
//

import UIKit

import MessageKit
import InputBarAccessoryView

class ChannelViewController: MessagesViewController {
    
    // MARK: - Properties
    
    let channel: Channel
    var sender = Sender(senderId: "any_unique_id", displayName: "Taeyoung")
    var messages: [Message] = []
    
    // MARK: - Lifecycles
    
    init(channel: Channel, sender: Sender = Sender(senderId: "any_unique_id", displayName: "Taeyoung")) {
        self.channel = channel
        self.sender = sender
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureDelegates()
    }
    
    // MARK: - API
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    private func configureDelegates() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        messageInputBar.delegate = self
    }
    
    // send 버튼 누르면 메시지를 CollectionView의 Cell에 표출하는 코드
    func insertNewMessage(_ message: Message) {
        messages.append(message)
        messages.sort()
        
        messagesCollectionView.reloadData()
    }

}
