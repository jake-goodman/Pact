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
    }
    
    static let shared = APIController()
    
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
                let participant = try? Participant(json: docData){
                completion(participant, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    
}
