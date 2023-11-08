//  ChannelAPI.swift
//  ChatDemo
//
//  Created by 진태영 on 11/1/23.
//

import Foundation

import FirebaseFirestore
import Firebase

class ChannelAPI {
    let firestoreDatabase = Firestore.firestore()
    var listener: ListenerRegistration?
    lazy var ChannelListener: CollectionReference? = {
        guard let uid = Auth.auth().currentUser?.uid else { return nil }
        return REF_USERS.document(uid).collection("channels")
    }()
    
    func createChannel(channelId: String, currentUser: User, toUser: User, completion: @escaping () -> Void) {
        let registrationMyChannel = Channel(toUser: toUser)
        let toChannel = Channel(toUser: currentUser)
        firestoreDatabase.collection("channels").document(channelId).setData(["members": 2]) { error in
            print("DEBUG - createChannel Error: \(String(describing: error?.localizedDescription))")
            print("DEBUG - create CHANNEL")
        }
        Task {
            try await addChannel(with: currentUser, channelId: channelId, channel: registrationMyChannel)
            try await addChannel(with: toUser, channelId: channelId, channel: toChannel)
            completion()
        }
    }
    
    func addChannel(with user: User, channelId: String, channel: Channel) async throws -> Void { // User channel 컬렉션에 채널 추가
        try await REF_USERS.document(user.uid).collection("channels").document(channelId).setData(channel.representation)
    }
    
    // 같은 사람 채팅방 중복 생성 방지 함수
    func checkExistChannel(currentUser: User, toUser: User, completion: @escaping(Bool, String?) -> Void) {
        REF_USERS.document(currentUser.uid).collection("channels").whereField("toUserId", isEqualTo: toUser.uid)
            .getDocuments { snapshot, error in
                guard let isExist = snapshot?.isEmpty else { return }
                let documentId = snapshot?.documents.first?.documentID
                
                completion(!isExist, documentId)
                
            }
    }
    
    // Firestore에 접근하여 실시간으로 데이터를 가져오는 메소드
    func subscribe(completion: @escaping (Result<[(Channel, DocumentChangeType)], Error>) -> Void) {
        guard let ChannelListener = ChannelListener else { return }
        ChannelListener.addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else {
                completion(.failure(error!))
                return
            }
            
            let result = snapshot.documentChanges
                .filter { Channel($0.document) != nil }
                .compactMap { (Channel($0.document)!, $0.type) }
            
            completion(.success(result))
        }
    }
    
    func updateChannelInfo(currentUser: User, toUser: User, channelId: String, message: Message) {
        var contentMessage: String {
            switch message.kind {
            case .photo(_):
                return "사진"
            case .text(let content):
                return content
            default: return ""
            }
        }
        
        let fromUpdateInfo = [
            "toUserName": toUser.fullName,
            "toUserId": toUser.uid,
            "recentDate": message.sentDate,
            "previewContent": contentMessage
        ] as [String : Any]
        
        let toUpdateInfo = [
            "toUserName": currentUser.fullName,
            "toUserId": currentUser.uid,
            "recentDate": message.sentDate,
            "previewContent": contentMessage,
            "alarmNumber": FieldValue.increment(Int64(1))
        ] as [String : Any]
        
        REF_USERS.document(currentUser.uid).collection("channels").document(channelId)
            .updateData(fromUpdateInfo) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
                
            }
        
        REF_USERS.document(toUser.uid).collection("channels").document(channelId)
            .updateData(toUpdateInfo) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
                
            }

    }
    
    func resetAlarmNumber(uid: String, channelId: String) {
        REF_USERS.document(uid).collection("channels").document(channelId)
            .updateData(["alarmNumber": 0])
    }
    
    func removeListener() {
        listener?.remove()
    }
}
