//
//  CalendarViewModel.swift
//  BudgetIsLife
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
        reloadData()
    }
}

// MARK: Public interface
extension CalendarViewModel {
    func reloadData() {
        self.dayViewModels = dayViewModelsBuilder()
        if let selectedDayViewModel = dayViewModels.first(where: { $0.monthDay == selectedMonthDay }) {
            setSelectedDayViewModel(selectedDayViewModel)
        }
    }
    
    var todayDayViewModel: CalendarDayViewModel? {
        guard let todayMonthDay else {
            return nil
        }
        
        return dayViewModels.first(
            where: { $0.monthDay.date == todayMonthDay.date }
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
    func dayViewModelsBuilder() -> [CalendarDayViewModel] {
        monthDays.map { monthDay in
            CalendarDayViewModel(
                calendarService: calendarService,
                monthDay: monthDay,
                isSelected: false
            )
        }
    }
    
    var monthDays: [MonthDay] {
        let dates = Calendar.current.monthDates(
            calendarService.todayDate
        )
        return dates.map {
            MonthDay(
                day: Calendar.current.dayInDate($0),
                date: $0
            )
        }
    }
    
    var todayMonthDay: MonthDay? {
        monthDay(for: calendarService.todayDate)
    }
    
    var selectedMonthDay: MonthDay? {
        monthDay(for: calendarService.selectedDate)
    }
    
    func monthDay(for date: Date) -> MonthDay? {
        let dayInMonth = Calendar.current.dayInDate(date)
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
