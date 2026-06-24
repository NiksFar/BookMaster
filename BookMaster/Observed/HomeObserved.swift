//
//  HomeObserved.swift
//  BookMaster
//
//  Created by Nikita on 05.06.2026.
//

import Foundation

extension HomeView {
    @Observable
    final class Observed {
        var currentMaster: Master = .init(name: "")
        var currentUser: Profile = .init(id: "", name: "", email: "", phone: 0)
        var filteredSlots = [TimeSlot]()
        
        init(userID: String = "ctEnu5q1ecPhQLu3w7yuBwUI4HE2", masterID: String = "fQv5sdCTIZNfV2wephtb") {
            fetchData(userID: userID, masterID: masterID)
        }
        
        func fetchData(userID: String, masterID: String) {
            Task {
                let profile = try await FirestoreService.shared.getProfile(userID)
               await MainActor.run {
                    self.currentUser = profile
                }
            }
            
            Task {
                let master = try await FirestoreService.shared.getMaster(byID: masterID)
                await MainActor.run {
                    self.currentMaster = master
                }
                let slots = try await FirestoreService.shared.getSlotsByMasterID(masterID)
                await MainActor.run {
                    self.currentMaster.slots = slots
                }
            }
        }
        
        func book(client: String, slot: TimeSlot) {
            Task {
                try await FirestoreService.shared.booking(slot: slot, clientID: client)
                fetchData(userID: currentUser.id, masterID: currentMaster.id)
            }
            
        }
    }
    
}
