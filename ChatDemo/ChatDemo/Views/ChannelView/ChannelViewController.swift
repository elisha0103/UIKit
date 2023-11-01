//
//  ChannelViewController.swift
//  ChatDemo
//
//  Created by 진태영 on 10/27/23.
//

import UIKit

import SnapKit
import MessageKit
import InputBarAccessoryView

class ChannelViewController: MessagesViewController {
    
    // MARK: - Properties
    
    var channels: [Channel] = []
    
    lazy var channelTableView: UITableView = {
        let view = UITableView()
        view.register(ChannelTableViewCell.self, forCellReuseIdentifier: ChannelTableViewCell.cellId)
        view.delegate = self
        view.dataSource = self
    }()
    
    // MARK: - Lifecycles
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - API
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    private func configure() {
        view.addSubview(channelTableView)
        channelTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        title = "Channel"
//        channels = getChannelMocks()
    }
}
