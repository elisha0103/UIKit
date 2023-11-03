//
//  AppDelegate+.swift
//  ChatDemo
//
//  Created by 진태영 on 11/3/23.
//

import UIKit

import FirebaseMessaging

extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {
    // 푸시 클릭
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        print("Tap Push", #function)
    }
    
    // 앱 화면 보고있는 중에 푸시 올 때
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        print("Notification UserInfo", notification.request.content.userInfo)
        guard let channelId = notification.request.content.userInfo["channelId"] as? String else {
            print("Push Noti on the app, No ChatRoomId", #function)
            return [.sound, .banner, .list]
        }
        
        if ChannelNotiManager.shared.currentChatRoomId == channelId {
            // 현재 활성화된 채팅방이 알림의 채팅방과 동일하다면, 알림 표시 안함
            print("CurrentChatRoom Noti", #function)
            return []
        }
        // 현재 활성화된 View가 알림의 채팅방 View가 아니라면, 알림 표시
        print("Push Noti on the app, Not match View", #function)
        
        return [.sound, .banner, .list]
    }
    
    /// FCMToken 업데이트시
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        print("FCM Token Messaging", #function, fcmToken ?? "")
        guard let fcmToken = fcmToken else { return }
        UserDefaults.standard.set(fcmToken, forKey: "FCMToken")
        
    }
    
    /// 스위즐링 No시 APNs 등록, 토큰 값 가져옴
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        let deviceTokenString = deviceToken.reduce("", { $0 + String(format: "%02X", $1) })
        print("APNS 등록, deviceToken", #function, deviceTokenString)
        Messaging.messaging().token { token, error in
            if let token = token {
                print("FCM 토큰", #function, token)
            }
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("NotificationError", error)
    }
}
