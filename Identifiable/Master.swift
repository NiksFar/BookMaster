//
//  Master.swift
//  BookMaster
//
//  Created by Nikita on 04.06.2026.
//

import Foundation
import FirebaseFirestore

class Master: Identifiable {
    var id: String
    var name: String
    var slots: [TimeSlot] = []
    
    init(id: String = UUID().uuidString, name: String) {
        self.id = id
        self.name = name
    }
    
    init?(snap: DocumentSnapshot) {
        guard let data = snap.data() else { return nil }
        guard let id = data["id"] as? String,
              let name = data["name"] as? String else { return nil }
        self.id = id
        self.name = name
    }
    
}
