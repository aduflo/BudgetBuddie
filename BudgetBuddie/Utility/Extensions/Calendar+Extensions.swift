//
//  Calendar+Extensions.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 1/15/26.
//

import Foundation

extension Calendar {
    /// Get the day associated with the date
    /// - Returns: The day of the date, represented as an `Int`
    func dayInMonth(_ date: Date) -> Int {
        component(
            .day,
            from: date
        )
    }
    
    /// Get the number of days in a month
    /// - Returns: The number of days, represented as an `Int`
    func daysInMonth(_ date: Date) -> Int {
        let dayRange = range(
            of: .day,
            in: .month,
            for: date
        )
        return dayRange?.count ?? 0
    }
    
    /// Get all dates associated with the month
    /// - Returns: All month days, represented as `Date`
    func monthDates(_ date: Date) -> [Date] {
        let dayRange = range(
            of: .day,
            in: .month,
            for: date
        )
        var dateComponents = dateComponents(
            [.day, .month, .year],
            from: date
        )
        return dayRange?.compactMap {
            dateComponents.day = $0
            return self.date(from: dateComponents)
        } ?? []
    }
    
    /// The current month, represented as an `Int`
    var month: Int {
        component(
            .month,
            from: Date()
        )
    }
    
    /// The current year, represented as an `Int`
    var year: Int {
        component(
            .year,
            from: Date()
        )
    }
}
