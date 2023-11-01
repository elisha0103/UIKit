//
//  ChatAPI.swift
//  ChatDemo
//
//  Created by 진태영 on 11/1/23.
//

import Foundation

import FirebaseFirestore
import FirebaseStorage

// 채팅 -> Firestore에 채팅 내역 저장, Firestore에 구독하고 있던 listener를 통해 데이터 획득, 업데이트
class ChatAPI {
    private let storage = Storage.storage().reference()
    let firestoreDatabase = Firestore.firestore()
    var listener: ListenerRegistration?
    var collectionListener: CollectionReference?
    
    func subscribe(id: String, completion: @escaping (Result<[Message], StreamError>) -> Void) {
        let streamPath = "channels/\(id)/\thread"
        
        removeListener()
        collectionListener = firestoreDatabase.collection(streamPath)
        
        listener = collectionListener?
            .addSnapshotListener { snapshot, error in
                guard let snapshot = snapshot else {
                    completion(.failure(StreamError.firestoreError(error)))
                    return
                }
                
                var messages: [Message] = []
                snapshot.documentChanges.forEach { change in
                    if let message = Message(document: change.document) {
                        if case .added = change.type {
                            messages.append(message)
                        }
                    }
                }
                completion(.success(messages))
            }
    }
    
    func save(_ message: Message, completion: ((Error?) -> Void)? = nil) {
        collectionListener?.addDocument(data: message.representation, completion: { error in
            completion?(error)
        })
    }
    
    func removeListener() {
        listener?.remove()
    }
}
