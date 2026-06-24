//
//  FirestoreService.swift
//  BookMaster
//
//  Created by Nikita on 29.05.2026.
//

import Foundation
import FirebaseFirestore

actor FirestoreService {
    static let shared = FirestoreService(); private init() {}
    let db = Firestore.firestore()
    var profiles: CollectionReference { db.collection("profiles") }
    var slots: CollectionReference { db.collection("slots") }
    var masters: CollectionReference { db.collection("masters") }
    
    func createProfile(_ profile: Profile) async throws -> Profile {
        try await profiles.document(profile.id).setData(profile.representation)
        return profile
    }
    
    func getProfile(_ id: String) async throws -> Profile {
        
        let snapshot = try await profiles.document(id).getDocument()
        
        let representation = snapshot.data()
        guard let representation = snapshot.data() else {
            throw DatabaseError.dataNotFound
        }
        
        guard let profile = Profile(representation: representation) else {
            throw DatabaseError.wrongData
        }
        
        return profile
    }
    
    func getSlotsByMasterID(_ masterID: String) async throws -> [TimeSlot] {
        let snapshot = try await slots.whereField("masterID", isEqualTo: masterID).getDocuments()
        
        let documents = snapshot.documents
        let slots = documents.compactMap { doc in
            TimeSlot(snap: doc)
        }
        return slots
    }
    
    func getMaster(byID id: String) async throws -> Master {
        let snapshot = try await masters.document(id).getDocument()
        guard let master = Master(snap: snapshot) else { throw DatabaseError.dataNotFound }
        return master
    }
    
    func booking(slot: TimeSlot, clientID: String) async throws {
        var repres = slot.representation
        repres["clientID"] = clientID
        try await slots.document(slot.id).setData(repres)
    }
    
}

enum DatabaseError: Error {
    case dataNotFound
    case wrongData
}
