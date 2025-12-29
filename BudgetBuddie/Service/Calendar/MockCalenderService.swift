//
//  MockCalenderService.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import Foundation

class MockCalenderService: CalenderServiceable {
    private(set) var selectedDate: Date = Date()
    
    func updateSelectedDate(_ date: Date) {
        selectedDate = date
    }
    
    func dayInMonth(_ date: Date) -> Int {
        4
    }
    
    func daysInMonth(_ date: Date) -> Int {
        31
    }
    
    func monthDays(_ date: Date) -> [Date] {
        let calendar = Calendar.current
        let dayRange = calendar.range(
            of: .day,
            in: .month,
            for: date
        )
        var dateComponents = calendar.dateComponents(
            [.day, .month],
            from: date
        )
        return dayRange?.compactMap { day in
            dateComponents.day = day
            return calendar.date(from: dateComponents)
        } ?? []
    }
    
    func currentMonthDay(_ date: Date) -> Int {
        3
    }
}
