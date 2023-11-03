//
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
    
    func createChannel(currentUser: User, toUser: User) {
        let channelId = UUID().uuidString
        let registrationMyChannel = Channel(toUser: toUser)
        let toChannel = Channel(toUser: currentUser)
        firestoreDatabase.collection("channels").document(channelId).setData(["members": 2])
        addChannel(with: currentUser, channelId: channelId, channel: registrationMyChannel)
        addChannel(with: toUser, channelId: channelId, channel: toChannel)
    }
    
    func addChannel(with user: User, channelId: String, channel: Channel) { // User channel 컬렉션에 채널 추가
        REF_USERS.document(user.uid).collection("channels").document(channelId).setData(channel.representation)
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
    
    func removeListener() {
        listener?.remove()
    }
}
