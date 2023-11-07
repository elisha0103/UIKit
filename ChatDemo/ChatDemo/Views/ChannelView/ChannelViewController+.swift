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
        cell.chatRoomLabel.text = channels[indexPath.row].toUserName
        cell.chatPreviewLabel.text = channels[indexPath.row].previewContent
        
        print("alarmNumber: \(channels[indexPath.row].alarmNumber)")
        if channels[indexPath.row].alarmNumber == 0 {
            cell.chatAlartNumberLabel.text = ""
            cell.chatAlartNumberLabel.isHidden = true
        } else {
            cell.chatAlartNumberLabel.isHidden = false
            cell.chatAlartNumberLabel.text = "\(channels[indexPath.row].alarmNumber)"
            cell.updateAlarmLabelSize()
        }
        
        let date = channels[indexPath.row].recentDate
        cell.recentDateLabel.text = formatDate(date)
        
        return cell
    }
    
    private func formatDate(_ date: Date) -> String {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        
        if calendar.isDateInToday(date) {
            formatter.dateFormat = "a h:mm"
        } else if calendar.isDateInYesterday(date) {
            return "어제"
        } else if calendar.isDate(date, equalTo: Date(), toGranularity: .year) {
            formatter.dateFormat = "M월 d일"
        } else {
            formatter.dateFormat = "yyyy년 M월 d일"
        }
        return formatter.string(from: date)
    }
}

extension ChannelViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = channels[indexPath.row]
        guard let currentUser = currentUser else { return }
        let viewController = ChatViewController(user: currentUser, channel: channel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
