//
//  Booking.swift
//  BookMaster
//
//  Created by Nikita on 24.05.2026.
//

import Foundation
import FirebaseFirestore

class TimeSlot: Identifiable {
    var id: String = UUID().uuidString
    var clientID: String?
    var date: Date
    var endDate: Date
    var masterID: String
    
    
    init(date: Date, masterID: String) {
        self.date = date
        self.masterID = masterID
        self.endDate = self.date.addingTimeInterval(7200)
    }
    
    init?(snap: QueryDocumentSnapshot) {
        let data = snap.data()
        guard let id = data["id"] as? String,
              let timestamp = data["date"] as? Timestamp,
              let endTimestamp = data["endDate"] as? Timestamp,
              let masterID = data["masterID"] as? String else { return nil }
        
        self.id = id
        self.date = timestamp.dateValue()
        self.endDate = timestamp.dateValue()
        self.masterID = masterID
        
        if let clientID = data["clientID"] as? String {
            self.clientID = clientID
        }
    }
    
}

extension TimeSlot {
    static let mockMasterID = UUID()
    static var mockData: [TimeSlot] = [
        TimeSlot(date: .init(timeIntervalSince1970: 1), masterID: .init()),
        TimeSlot(date: .init(timeIntervalSince1970: 2), masterID: .init()),
        TimeSlot(date: .init(timeIntervalSince1970: 3), masterID: .init()),
        TimeSlot(date: .init(timeIntervalSince1970: 4), masterID: .init())
    ]
}
