//
//  CalendarViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import Foundation

@Observable
class CalendarViewModel {
    // Instance vars
    private let calendarService: CalendarServiceable
    
    private(set) var dayViewModels: [CalendarDayViewModel] = []
    private(set) var selectedDayViewModel: CalendarDayViewModel? = nil
    
    // Constructors
    init(
        calendarService: CalendarServiceable
    ) {
        self.calendarService = calendarService
    }
}

// MARK: Public interface
extension CalendarViewModel {
    func reloadData() {
        dayViewModels = dayViewModelsBuilder()
        selectedDayViewModel = nil
    }
    
    var currentDayViewModel: CalendarDayViewModel? {
        guard let currentMonthDay = currentMonthDay else {
            return nil
        }
        
        return dayViewModels.first(
            where: { $0.monthDay.day == currentMonthDay.day }
        )
    }
    
    func updateSelectedDate(_ date: Date) {
        calendarService.updateSelectedDate(date)
    }
    
    func setSelectedDayViewModel(_ viewModel: CalendarDayViewModel) {
        selectedDayViewModel = viewModel
    }
}

// MARK: Private interface
private extension CalendarViewModel {
    var monthDays: [MonthDay] {
        let dates = Calendar.current.monthDates(
            calendarService.selectedDate
        )
        return dates.map {
            MonthDay(
                day: Calendar.current.dayInDate($0),
                date: $0
            )
        }
    }
    
    var currentMonthDay: MonthDay? {
        let dayInMonth = Calendar.current.dayInDate(calendarService.selectedDate)
        return monthDays.first { $0.day == dayInMonth }
    }
    
    func dayViewModelsBuilder() -> [CalendarDayViewModel] {
        monthDays.map { monthDay in
            CalendarDayViewModel(
                monthDay: monthDay,
                isSelected: false
            )
        }
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
