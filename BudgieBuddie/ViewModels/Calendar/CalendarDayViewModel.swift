//
//  CalendarDayViewModel.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 12/29/25.
//

import Foundation

@Observable
class CalendarDayViewModel: Identifiable {
    // Instance vars
    let monthDay: MonthDay
    private(set) var isSelected: Bool
    
    // Identifiable
    let id = UUID()
    
    // Constructors
    init(
        monthDay: MonthDay,
        isSelected: Bool
    ) {
        self.monthDay = monthDay
        self.isSelected = isSelected
    }
}

// MARK: Equatable
extension CalendarDayViewModel: Equatable {
    static func == (lhs: CalendarDayViewModel, rhs: CalendarDayViewModel) -> Bool {
        lhs.monthDay == rhs.monthDay
    }
}

// MARK: Public interface
extension CalendarDayViewModel {
    func setSelected(_ selected: Bool) {
        isSelected = selected
    }
    
    var displayMonthDay: String {
        monthDay.date.monthDayString
    }
    
    var isToday: Bool {
        Calendar.current.isDateInToday(monthDay.date)
    }
}
