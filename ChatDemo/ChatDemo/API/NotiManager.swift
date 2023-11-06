//
//  ChannelNotiManager.swift
//  ChatDemo
//
//  Created by 진태영 on 11/3/23.
//

import Foundation

import Alamofire

class NotiManager {
    static let shared = NotiManager()
    
    let headers: HTTPHeaders = [
        "Content-Type": "application/json",
        "Authorization": "key=AAAAB_ITJVM:APA91bHl5I2HIaB2_QLnoYfMOAxpyL4okV7UmqSRPcUzDAcg_lyG2ztT8dNwszWZn2jVB6FXS9dJhMGc7BFqtL6mV1maAL1qBj9p64S30YX4h4FS-_ICANDGSK-6E0Qw4q8uNuLmh_kn"
    ]
    
    let fcmUrlString = "https://fcm.googleapis.com/fcm/send"
    
    var currentChatRoomId: String?
    
    private init() { }
    
    func pushNotification(channel: Channel, content: String, fcmToken: String, from user: User) {
        let value = [
            "title": user.fullName,
            "body": content,
            "sound": "default"
        ]
        let channelIdDictionary = ["channelId": channel.id,
                                   "fromUserId": user.uid]
        let params: Parameters = [
            "to": fcmToken,
            "notification": value,
            "data": channelIdDictionary
        ]
        let dataRequest = AF.request(fcmUrlString,
                                     method: .post,
                                     parameters: params,
                                     encoding: JSONEncoding.default,
                                     headers: headers)
        dataRequest.response { response in
            debugPrint(response.data as Any)
        }
    }
    
}
