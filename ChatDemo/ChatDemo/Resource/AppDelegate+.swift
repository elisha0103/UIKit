//
//  AppDelegate+.swift
//  ChatDemo
//
//  Created by 진태영 on 11/3/23.
//

import UIKit

import Firebase
import FirebaseMessaging

extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {
//    // 푸시 탭 핸들러
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
//        print("Tap Push", #function)
//    }
    
    // 푸시 탭 핸들러
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Tap Push", #function)
        guard let channelId = response.notification.request.content.userInfo["channelId"] as? String,
        let fromUserId = response.notification.request.content.userInfo["fromUserId"] as? String else {
            print("Push Noti on the app, No ChatRoomId", #function)
            return
        }
        if let uid = Auth.auth().currentUser?.uid {
            Task {
                do {
                    let currentUser = try await AuthAPI.shared.fetchUser(uid: uid)
                    let fromUser = try await AuthAPI.shared.fetchUser(uid: fromUserId)
                    let channel = Channel(id: channelId, toUser: fromUser)
                    let chatViewController = ChatViewController(user: currentUser, channel: channel)
                    let channelViewController = ChannelViewController()
                    
                    var navigationController = BaseNavigationController(rootViewController: channelViewController)
                    navigationController.pushViewController(chatViewController, animated: true)
                    if UIApplication.shared.applicationState == .active {
                        window?.rootViewController = navigationController
                    } else {
                        window?.rootViewController = navigationController
                        window?.makeKeyAndVisible()
                    }
                } catch let error as NSError {
                    print("FCM UserFetch Error: \(error.localizedDescription)")
                }
                
            }
        } else {
            var navigationController = BaseNavigationController(rootViewController: LoginViewController())
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }

    }
    
    // 노티 푸시 수신
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        print("Notification UserInfo", notification.request.content.userInfo)
        guard let channelId = notification.request.content.userInfo["channelId"] as? String,
                Auth.auth().currentUser != nil else {
            print("Push Noti on the app, No ChatRoomId", #function)
            return [.sound, .banner, .list]
        }
        
        if NotiManager.shared.currentChatRoomId == channelId {
            // 현재 활성화된 채팅방이 알림의 채팅방과 동일하다면, 알림 표시 안함
            print("CurrentChatRoom Noti", #function)
            let channelAPI = ChannelAPI()
            if let uid = Auth.auth().currentUser?.uid {
//                channelAPI.resetAlarmNumber(uid: uid, channelId: channelId)
            }
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
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("NotificationError", error)
    }
}
