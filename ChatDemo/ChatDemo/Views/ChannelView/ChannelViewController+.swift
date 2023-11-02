//
//  ChannelViewController+.swift
//  ChatDemo
//
//  Created by 진태영 on 10/27/23.
//

import UIKit

import MessageKit
import InputBarAccessoryView

extension ChannelViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChannelTableViewCell.cellId, for: indexPath) as! ChannelTableViewCell
        
        return cell
    }
}

extension ChannelViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = channels[indexPath.row]
        let viewController = ChatViewController(user: currentUser, channel: channel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
