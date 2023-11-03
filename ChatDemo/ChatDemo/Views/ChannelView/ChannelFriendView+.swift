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
        let friend = friendUser[indexPath.row].fullName
        channelAPI.createChannel(with: friend)
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
