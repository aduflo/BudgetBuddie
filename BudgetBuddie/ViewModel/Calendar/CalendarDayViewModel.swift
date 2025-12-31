//
//  CalendarDayViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/29/25.
//

import Foundation

@Observable
class CalendarDayViewModel: Identifiable {
    // Instance vars
    var isSelected: Bool
    let text: String
    let monthDay: MonthDay
    
    // Identifiable
    let id = UUID()
    
    // Constructors
    init(
        isSelected: Bool,
        text: String,
        monthDay: MonthDay
    ) {
        self.isSelected = isSelected
        self.text = text
        self.monthDay = monthDay
    }
}
