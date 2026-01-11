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
            let date = monthDay.date
            return CalendarDayViewModel(
                monthDay: monthDay,
                isSelected: false
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
        let dates = CalendarService.monthDates(
            calendarService.selectedDate
        )
        return dates.map {
            MonthDay(
                day: CalendarService.dayInMonth($0),
                date: $0
            )
        }
    }
    
    var currentMonthDay: MonthDay? {
        let dayInMonth = CalendarService.dayInMonth(calendarService.selectedDate)
        return monthDays.first { $0.day == dayInMonth }
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
