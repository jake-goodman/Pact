//
//  APIController.swift
//  Pact
//
//  Created by Jake Goodman on 5/28/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

typealias AuthCallback = (User?, Error?)->Void

class APIController {
    
    fileprivate enum FirestoreKeys {
        static let participant: String = "participant"
        static let entries: String = "entries"
    }
    
    static let shared = APIController()
    
    var currentParticipant: Participant?
    var currentUser: User? {
        get {
            return auth.currentUser
        }
    }
    
    
    fileprivate let auth = Auth.auth()
    fileprivate let db = Firestore.firestore()
    
    
    private init() {
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
    // MARK: - Authentication
    
    func createUser(withEmail email: String, password: String, _ completion: @escaping AuthCallback) {
        auth.createUser(withEmail: email, password: password) { (user, error) in
            DispatchQueue.main.async {
                completion(user, error)
            }
        }
    }
    
    func signIn(withEmail email: String, password: String, _ completion: @escaping AuthCallback) {
        auth.signIn(withEmail: email, password: password) { (user, error) in
            DispatchQueue.main.async {
                completion(user, error)
            }
        }
    }
    
    // MARK: - Participant
    
    func createParticipant(forUser userId: String, withName name: String, completion: @escaping (Participant?, Error?)->Void) {
        let doc = db.collection(FirestoreKeys.participant).document(userId)
        let participant = Participant(id: userId, name: name)
        doc.setData(participant.toJSON()) { (error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error)
                } else {
                    completion(participant, nil)
                }
            }
        }
    }
    
    func retrieveParticipant(forUser userId: String, completion: @escaping (Participant?, Error?)->Void) {
        let docRef = db.collection(FirestoreKeys.participant).document(userId)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists,
                let docData = document.data(),
                let participant = try? Participant(json: docData) {
                completion(participant, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    // MARK: - Logs
    
    func createActivityLog(forUser userId: String, numHours: Float, description: String, completion: @escaping (ActivityLog?, Error?)->Void) {
        let doc = db.collection(FirestoreKeys.participant).document(userId).collection(FirestoreKeys.entries).document()
        let log = ActivityLog(id: doc.documentID, numHours: numHours, description: description)
        doc.setData(log.toJSON()) { (error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error)
                } else {
                    completion(log, nil)
                }
            }
        }
    }
    
    func retrieveActivityLogs(forUser userId: String, completion: @escaping ([ActivityLog], Error?)->Void) {
        let collectionRef = db.collection(FirestoreKeys.participant).document(userId).collection(FirestoreKeys.entries)
        collectionRef.getDocuments() { (snapshot, error) in
            var logs: [ActivityLog] = []
            if let documents = snapshot?.documents.filter({$0.exists}) {
                for document in documents {
                    if let log = try? ActivityLog(json: document.data()) {
                        logs.append(log)
                    }
                }
            }
            DispatchQueue.main.async {
                completion(logs, error)
            }
        }
    }

}
