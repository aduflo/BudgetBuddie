//
//  CalendarViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import Foundation

struct CalendarViewModel {
    // Instance vars
    private let calendarService: CalenderServiceable
    
    // Constructors
    init(
        calendarService: CalenderServiceable
    ) {
        self.calendarService = calendarService
    }
}

// MARK: Public interface
extension CalendarViewModel {
    var currentMonthDay: MonthDay? {
        let currentDay = calendarService.currentMonthDay(calendarService.selectedDate)
        return monthDays.first { $0.day == currentDay }
    }
    
    var monthDays: [MonthDay] {
        let days = calendarService.monthDays(
            calendarService.selectedDate
        )
        return days.map {
            MonthDay(
                day: calendarService.dayInMonth($0),
                date: $0
            )
        }
    }
    
    func displayMonthDay(_ date: Date) -> String {
        date.formatted(.dateTime.day(.twoDigits).month(.twoDigits))
    }
}

// MARK: - Mocks
extension CalendarViewModel {
    static func mock() -> CalendarViewModel {
        CalendarViewModel(
            calendarService: MockCalenderService()
        )
    }
}
