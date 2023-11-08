//
//  ChannelFriendView+.swift
//  ChatDemo
//
//  Created by 진태영 on 11/3/23.
//

import UIKit

extension ChannelFriendView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friend = friendUser[indexPath.row]
        guard let currentUser = currentUser else { return }
        channelAPI.checkExistChannel(currentUser: currentUser, toUser: friend) { isExist, channelId in
            print("isExist: \(isExist)")
            if isExist, let channelId = channelId {
                let channel = Channel(id: channelId, toUser: friend)
                let viewController = ChatViewController(user: currentUser, channel: channel)
                self.navigationController?.pushViewController(viewController, animated: true)
            } else {
                let channel = Channel(id: UUID().uuidString, toUser: friend)
                let viewController = ChatViewController(user: currentUser, channel: channel, isNewChat: true)
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
//        dismiss(animated: true)
    }
}

extension ChannelFriendView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChannelTableViewCell.cellId, for: indexPath)
        as! ChannelTableViewCell
        cell.chatRoomLabel.text = friendUser[indexPath.row].fullName
        
        return cell
    }
    
    
}
