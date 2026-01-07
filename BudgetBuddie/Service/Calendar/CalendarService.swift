//
//  CalendarService.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import Foundation

class CalendarService: CalendarServiceable {
    // Instance vars
    private let calendar = Calendar.current
    
    // CalendarServiceable    
    private(set) var selectedDate: Date = Date() {
        didSet {
            postNotificationSelectedDateUpdated()
        }
    }
    
    func updateSelectedDate(_ date: Date) {
        selectedDate = date
    }
    
    static func dayInMonth(_ date: Date) -> Int {
        Calendar.current.component(
            .day,
            from: date
        )
    }
    
    static func daysInMonth(_ date: Date) -> Int {
        let dayRange = Calendar.current.range(
            of: .day,
            in: .month,
            for: date
        )
        return dayRange?.count ?? 0
    }
    
    static func monthDates(_ date: Date) -> [Date] {
        let calendar = Calendar.current
        let dayRange = calendar.range(
            of: .day,
            in: .month,
            for: date
        )
        var dateComponents = calendar.dateComponents(
            [.day, .month, .year],
            from: date
        )
        return dayRange?.compactMap {
            dateComponents.day = $0
            return calendar.date(from: dateComponents)
        } ?? []
    }
}

// MARK: Private interface
private extension CalendarService {
    func postNotificationSelectedDateUpdated() {
        NotificationCenter.default.post(.SelectedDateUpdated)
    }
}
