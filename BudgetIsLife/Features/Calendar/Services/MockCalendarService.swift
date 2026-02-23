//
//  MockCalendarService.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 12/28/25.
//

import Foundation

class MockCalendarService: CalendarServiceable {
    private(set) var todayDate: Date = Date()
    
    func updateTodayDate(_ date: Date) {
        todayDate = date
    }
    
    private(set) var selectedDate: Date = Date()
    
    func updateSelectedDate(_ date: Date) {
        selectedDate = date
    }
}
