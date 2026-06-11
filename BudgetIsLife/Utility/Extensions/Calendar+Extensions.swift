//
//  Calendar+Extensions.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 1/15/26.
//

import Foundation

extension Calendar {
    /// Get the day associated with the date
    /// - Returns: The day of the date, represented as an `Int`
    func dayInDate(_ date: Date) -> Int {
        component(
            .day,
            from: date
        )
    }
    
    /// Get the month associated with the date
    /// - Returns: The day of the date, represented as an `Int`
    func monthInDate(_ date: Date) -> Int {
        component(
            .month,
            from: date
        )
    }
    
    /// Get the year associated with the date
    /// - Returns: The day of the date, represented as an `Int`
    func yearInDate(_ date: Date) -> Int {
        component(
            .year,
            from: date
        )
    }
    
    /// Get the number of days in the month associated with the date
    /// - Returns: The number of days, represented as an `Int`
    func daysInMonthInDate(_ date: Date) -> Int {
        let dayRange = range(
            of: .day,
            in: .month,
            for: date
        )
        return dayRange?.count ?? 0
    }
    
    /// Get all dates associated with the month
    /// - Returns: Days represented as `Date`
    func monthDates(_ date: Date) -> [Date] {
        guard let dayRange = range(
            of: .day,
            in: .month,
            for: date
        ) else { return [] }
        
        var dateComponents = dateComponents(
            [.day, .month, .year],
            from: date
        )
        return dayRange.compactMap {
            dateComponents.day = $0
            return self.date(from: dateComponents)
        }
    }
    
    /// Get all dates associated with the month, up to and including the provided date
    /// - Returns: Days represented as `Date`
    func monthDatesUpTo(_ date: Date) -> [Date] {
        let startOfMonthComponents = dateComponents([.year, .month], from: date)
        guard let startOfMonth = self.date(from: startOfMonthComponents) else {
            return []
        }
        
        let dayRange = dayInDate(startOfMonth)...dayInDate(date)
        var dateComponents = dateComponents(
            [.day, .month, .year],
            from: date
        )
        return dayRange.compactMap {
            dateComponents.day = $0
            return self.date(from: dateComponents)
        }
    }
    
    /// Get all dates associated with the month, up to but _not_ including the provided date
    /// - Returns: Days represented as `Date`
    func monthDatesPriorTo(_ date: Date) -> [Date] {
        let startOfMonthComponents = dateComponents([.year, .month], from: date)
        guard let startOfMonth = self.date(from: startOfMonthComponents) else {
            return []
        }
        
        let dayRange = dayInDate(startOfMonth)..<dayInDate(date)
        var dateComponents = dateComponents(
            [.day, .month, .year],
            from: date
        )
        return dayRange.compactMap {
            dateComponents.day = $0
            return self.date(from: dateComponents)
        }
    }
}
