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
}

enum DatabaseError: Error {
    case dataNotFound
    case wrongData
}
