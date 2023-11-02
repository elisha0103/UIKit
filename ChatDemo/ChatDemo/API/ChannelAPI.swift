//
//  ChannelAPI.swift
//  ChatDemo
//
//  Created by 진태영 on 11/1/23.
//

import Foundation

import FirebaseFirestore
import FirebaseStorage

class ChannelAPI {
    private let storage = Storage.storage().reference()
    let firestoreDatabase = Firestore.firestore()
    var listener: ListenerRegistration?
    lazy var ChannelListener: CollectionReference = {
        return firestoreDatabase.collection("channels")
    }()
    
    func createChannel(with channelName: String) {
        let channel = Channel(name: channelName)
        ChannelListener.addDocument(data: channel.representation) { error in
            if let error = error {
                print("Error saving Channel: \(error.localizedDescription)")
            }
        }
    }
    
    // Firestore에 접근하여 실시간으로 데이터를 가져오는 메소드
    func subscribe(completion: @escaping (Result<[(Channel, DocumentChangeType)], Error>) -> Void) {
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
