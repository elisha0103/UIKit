//
//  ChannelViewController.swift
//  ChatDemo
//
//  Created by 진태영 on 10/27/23.
//

import UIKit

import SnapKit
import Firebase

class ChannelViewController: BaseViewController {
    
    // MARK: - Properties
    
    var channels: [Channel] = []
    private let channelAPI = ChannelAPI()
    
    lazy var channelTableView: UITableView = {
        let view = UITableView()
        view.register(ChannelTableViewCell.self, forCellReuseIdentifier: ChannelTableViewCell.cellId)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    // MARK: - Lifecycles
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - API
    
    private func setupListener() {
        channelAPI.subscribe { [weak self] result in
            switch result {
            case .success(let data):
                self?.updateCell(to: data)
            case .failure(let error):
                print("DEBUG - setupListener Error: \(error.localizedDescription)")
            }
        }
    }
    
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
    
    private func updateCell(to data: [(Channel, DocumentChangeType)]) {
        data.forEach { channel, documentChangeType in
            switch documentChangeType {
            case .added:
                addChannelToTable(channel)
            case .modified:
                updateChannelInTable(channel)
            case .removed:
                removeChannelFromTable(channel)
            }
        }
    }
    
    private func addChannelToTable(_ channel: Channel) {
        guard channels.contains(channel) == false else { return }
        
        channels.append(channel)
        channels.sort()
        
        guard let index = channels.firstIndex(of: channel) else { return }
        channelTableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    private func updateChannelInTable(_ channel: Channel) {
        guard let index = channels.firstIndex(of: channel) else { return }
        channels[index] = channel
        channelTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    private func removeChannelFromTable(_ channel: Channel) {
        guard let index = channels.firstIndex(of: channel) else { return }
        channels.remove(at: index)
        channelTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}
