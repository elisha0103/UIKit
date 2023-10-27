//
//  ChatViewController.swift
//  ChatDemo
//
//  Created by 진태영 on 10/27/23.
//

import UIKit

import MessageKit
import InputBarAccessoryView
import Photos

final class ChatViewController: MessagesViewController {

    // MARK: - Properties
    
    let channel: Channel
    var sender = Sender(senderId: "any_unique_id", displayName: "Taeyoung")
    var message: [Message] = []
    
    lazy var cameraBarButtonItem: InputBarButtonItem = {
        let button = InputBarButtonItem(type: .system)
        button.tintColor = .primary
        button.image = UIImage(systemName: "camera")
        button.addTarget(self, action: #selector(didTapCameraButton), for: .touchUpInside)
        return button
    }()
    
    private var isSendingPhoto = false {
        didSet {
            messageInputBar.leftStackViewItems.forEach {
                guard let item = $0 as? InputBarButtonItem else { return }
                item.isEnabled = !self.isSendingPhoto
            }
        }
    }
    
    // MARK: - Lifecycles
    
    init(channel: Channel) {
        self.channel = channel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Helpers

}
