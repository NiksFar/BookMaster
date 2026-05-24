//
//  Date+Ext.swift
//  BookMaster
//
//  Created by Nikita on 21.05.2026.
//

import Foundation

extension Date {
    
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    var isTheSameHour: Bool {
        Calendar.current.compare(self, to: Date(), toGranularity: .hour) == .orderedSame
    }
    
    var isPast: Bool {
        Calendar.current.compare(self, to: Date(), toGranularity: .hour) == .orderedAscending
    }
    
    var isFuture: Bool {
        Calendar.current.compare(self, to: Date(), toGranularity: .hour) == .orderedDescending
    }
    
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func fetchWeek(_ date: Date = Date()) -> [WeekDay] {
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: date)
        var week: [WeekDay] = []
        let weekForDate = calendar.dateInterval(of: .weekOfMonth, for: startOfDate)
        
        guard let startOfWeek = weekForDate?.start else { return week }
        
        (0..<7).forEach { index in
            if let weekDayDate = calendar.date(byAdding: .day, value: index, to: startOfWeek) {
                week.append(WeekDay(date: weekDayDate))
            }
        }
            return week
    }
    
    func createNextWeek() -> [WeekDay] {
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: self)
        guard let nextDate = calendar.date(byAdding: .day, value: 1, to: startOfDate) else { return [] }
        return fetchWeek(nextDate)
    }
    
    func createPreviousWeek() -> [WeekDay] {
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: self)
        guard let previousDate = calendar.date(byAdding: .day, value: -1, to: startOfDate) else { return [] }
        return fetchWeek(previousDate)
    }
    
    struct WeekDay: Identifiable {
        var id: UUID = UUID()
        var date: Date
    }
}
