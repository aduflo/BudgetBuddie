//
//  MockCalendarService.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import Foundation

class MockCalendarService: CalendarServiceable {
    private(set) var selectedDate: Date = Date()
    
    func updateSelectedDate(_ date: Date) {
        selectedDate = date
    }
}
