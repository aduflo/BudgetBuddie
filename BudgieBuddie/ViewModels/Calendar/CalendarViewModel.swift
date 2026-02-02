//
//  CalendarViewModel.swift
//  BudgieBuddie
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
        // rebuild dayViewModels
        dayViewModels = dayViewModelsBuilder()
        
        // null out selectedDayViewModel if not contained in dayViewModels
        if dayViewModels.contains(where: { $0 == selectedDayViewModel }) == false {
            selectedDayViewModel = nil
        }
    }
    
    var currentDayViewModel: CalendarDayViewModel? {
        guard let currentMonthDay = currentMonthDay else {
            return nil
        }
        
        return dayViewModels.first(
            where: { $0.monthDay.day == currentMonthDay.day }
        )
    }
    
    func setSelectedDayViewModel(_ viewModel: CalendarDayViewModel) {
        // untoggle previously selected VM, if needed
        if let selectedDayViewModel {
            selectedDayViewModel.setSelected(false)
        }
        
        // toggle newly-to-be-selected VM, assign value, and update calendarService
        viewModel.setSelected(true)
        selectedDayViewModel = viewModel
        calendarService.updateSelectedDate(viewModel.monthDay.date)
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
