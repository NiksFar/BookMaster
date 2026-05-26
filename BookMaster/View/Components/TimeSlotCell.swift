//
//  TimeSlotCell.swift
//  BookMaster
//
//  Created by Nikita on 24.05.2026.
//

import SwiftUI

struct TimeSlotCell: View {
    @State var observed: Observed
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text(observed.timeLabel)
                .font(.title3.bold())
            Text(observed.isFreeDescription)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 19)
        .padding(.vertical, 12)
        .background(.bgGreen)
        .clipShape(.rect(cornerRadius: 14))
        .offset(x: 42)
    }
}

extension TimeSlotCell {
    @Observable
    class Observed {
        var timeSlot: TimeSlot
        
        var timeLabel: String {
            "\(timeSlot.date.formatted(date: .omitted, time: .shortened)) - \(timeSlot.date.formatted(date: .omitted, time: .shortened))"
        }
        
        var isFreeDescription: String {
            guard timeSlot.clientID != nil else {
                return "Time Slot is Free"
            }
            if timeSlot.clientID == currentUserID {
                return "It is booked for you"
            }
            return "Time Slot is Busy"
        }
        
        var bgColor: Color {
            
            if timeSlot.clientID == nil {
                return .bgGreen
            }
            
           return timeSlot.clientID == currentUserID ? .bgYellow : .bgRed
        }
        
        init(timeSlot: TimeSlot) {
            self.timeSlot = timeSlot
        }
    }
}

//#Preview {
//    TimeSlotCell(observed: .init(timeSlot: .init(date: .now, masterID: TimeSlot.mockMasterID)))
//}
