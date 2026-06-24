//
//  AuthObserved.swift
//  BookMaster
//
//  Created by Nikita on 29.05.2026.
//

import Foundation

extension AuthView {
    @Observable
    final class Observed {
        var currentProfile: Profile?
        
        func auth(email: String, password: String) {
            Task {
                let profile = try await AuthService.shared.signIn(withEmail: email, password: password)
                await MainActor.run {
                    self.currentProfile = profile
                }
            }
        }
        
        func signUp(email: String, password: String, confirm: String) {
            guard password == confirm else { return }
            Task {
                let profile = try await AuthService.shared.signUp(withEmail: email, password: password)
                await MainActor.run {
                    self.currentProfile = profile
                }
            }
        }
    }
}
