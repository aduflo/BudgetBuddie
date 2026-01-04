//
//  CalendarServiceable.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import Foundation

protocol CalendarServiceable {
    var selectedDate: Date { get }
    func updateSelectedDate(_ date: Date)
    /// Get the day associated with the date
    /// - Returns: The day of the date, represented as an `Int`
    func dayInMonth(_ date: Date) -> Int
    /// Get the number of days in a month
    /// - Returns: The number of days, represented as an `Int`
    func daysInMonth(_ date: Date) -> Int
    func monthDates(_ date: Date) -> [Date]
    func currentMonthDay(_ date: Date) -> Int
}
