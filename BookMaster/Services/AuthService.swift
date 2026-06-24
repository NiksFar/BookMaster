//
//  AuthService.swift
//  BookMaster
//
//  Created by Nikita on 29.05.2026.
//

import FirebaseAuth

actor AuthService {
    static let shared = AuthService(); private init() {}
    let auth = Auth.auth()
    var currentUser: User? { auth.currentUser }
    
    //TODO: Auth
    func signIn(withEmail email: String, password: String) async throws -> Profile {
        let user = try await auth.signIn(withEmail: email, password: password).user
        let profile = try await FirestoreService.shared.getProfile(user.uid)
        return profile
    }
    
    //TODO: Reg
    func signUp(withEmail email: String, password: String) async throws -> Profile {
        let user = try await auth.createUser(withEmail: email, password: password).user
        let profile = await Profile(id: user.uid, name: "", email: user.email!, phone: 0)
        return try await FirestoreService.shared.createProfile(profile)
    }
    
    //TODO: Out
    func signOut() { try? auth.signOut() }
    
}
