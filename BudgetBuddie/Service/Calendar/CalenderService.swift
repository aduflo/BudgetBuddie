//
//  CalenderService.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import Foundation

class CalenderService: CalenderServiceable {
    // Instance vars
    private let calendar = Calendar.current
    
    // CalenderServiceable
    
    var selectedDate: Date = Date() {
        didSet {
            postNotificationSelectedDateUpdated()
        }
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
    
    func monthDays(_ date: Date) -> [Date] {
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
    
    func currentMonthDay(_ date: Date) -> Int {
        let dateComponents = calendar.dateComponents(
            in: TimeZone.current,
            from: date
        )
        return dateComponents.day ?? 0
    }
}

// MARK: Private interface
private extension CalenderService {
    func postNotificationSelectedDateUpdated() {
        NotificationCenter.default.post(.SelectedDateUpdated)
    }
}
