//
//  Booking.swift
//  BookMaster
//
//  Created by Nikita on 24.05.2026.
//

import Foundation

class TimeSlot: Identifiable {
    var id: UUID = .init()
    var clientID: UUID?
    var date: Date
    var endDate: Date
    var masterID: UUID
    
    
    init(date: Date, masterID: UUID) {
        self.date = date
        self.masterID = masterID
        self.endDate = self.date.addingTimeInterval(3600)
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
