//
//  CalendarService.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 12/28/25.
//

import Foundation

class CalendarService: CalendarServiceable {
    // CalendarServiceable
    private(set) var todayDate: Date {
        didSet {
            updateSelectedDate(todayDate)
            postNotificationDidUpdateTodayDate()
        }
    }
    
    func updateTodayDate(_ date: Date) {
        guard date.isSameDayAs(todayDate) == false else {
            return
        }
        
        todayDate = date
    }
    
    private(set) var selectedDate: Date {
        didSet {
            postNotificationDidUpdateSelectedDate()
        }
    }
    
    func updateSelectedDate(_ date: Date) {
        selectedDate = date
    }
    
    // Constructors
    init(
        todayDate: Date,
        selectedDate: Date
    ) {
        self.todayDate = todayDate
        self.selectedDate = selectedDate
    }
}

// MARK: Private interface
private extension CalendarService {
    func postNotificationDidUpdateTodayDate() {
        NotificationCenter.default.post(.CalendarServiceDidUpdateTodayDate)
    }
    
    func postNotificationDidUpdateSelectedDate() {
        NotificationCenter.default.post(.CalendarServiceDidUpdateSelectedDate)
    }
}
