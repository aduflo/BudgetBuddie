//
//  CalendarViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import Foundation

class CalendarViewModel {
    // Instance vars
    lazy var dayViewModels: [CalendarDayViewModel] = {
        monthDays.map { monthDay in
            CalendarDayViewModel(
                isSelected: false,
                text: displayMonthDay(monthDay.date),
                monthDay: monthDay
            )
        }
    }()
    private(set) var selectedDayViewModel: CalendarDayViewModel? = nil
    private let calendarService: CalendarServiceable
    
    // Constructors
    init(
        calendarService: CalendarServiceable
    ) {
        self.calendarService = calendarService
    }
}

// MARK: Public interface
extension CalendarViewModel {
    var currentDayViewModel: CalendarDayViewModel? {
        guard let currentMonthDay = currentMonthDay else {
            return nil
        }
        
        return dayViewModels.first(where: { $0.monthDay.day == currentMonthDay.day })
    }
    
    func updateSelectedDate(_ date: Date) {
        calendarService.updateSelectedDate(date)
    }
}

// MARK: Private interface
private extension CalendarViewModel {
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
    
    var currentMonthDay: MonthDay? {
        let currentDay = calendarService.currentMonthDay(calendarService.selectedDate)
        return monthDays.first { $0.day == currentDay }
    }
    
    func displayMonthDay(_ date: Date) -> String {
        date.formatted(.dateTime.day(.twoDigits).month(.twoDigits))
    }
}

// MARK: - Mocks
extension CalendarViewModel {
    static func mock() -> CalendarViewModel {
        CalendarViewModel(
            calendarService: MockCalendarService()
        )
    }
}
