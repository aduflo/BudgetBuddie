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
    
    func dayInMonth(_ date: Date) -> Int {
        calendar.component(.day, from: date)
    }
    
    func daysInMonth(_ date: Date) -> Int {
        let dayRange = calendar.range(
            of: .day,
            in: .month,
            for: date
        )
        return dayRange?.count ?? 0
    }
    
    func monthDates(_ date: Date) -> [Date] {
        calendar.monthDatesFor(date)
    }
    
    func currentMonthDay(_ date: Date) -> Int {
        let dateComponents = calendar.dateComponents(
            in: TimeZone.current,
            from: date
        )
        return dateComponents.day ?? 0
    }
}

// MARK: Private interface
private extension CalendarService {
    func postNotificationSelectedDateUpdated() {
        NotificationCenter.default.post(.SelectedDateUpdated)
    }
}
