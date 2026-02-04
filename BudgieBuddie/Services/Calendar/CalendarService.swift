//
//  CalendarService.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import Foundation

class CalendarService: CalendarServiceable {
    // CalendarServiceable
    private(set) var todayDate: Date = Date() {
        didSet {
            postNotificationDidUpdateTodayDate()
        }
    }
    
    func updateTodayDate(_ date: Date) {
        let isSameDay = Calendar.current.isDate(date, inSameDayAs: todayDate)
        guard isSameDay == false else {
            return
        }
        
        todayDate = date
    }
    
    private(set) var selectedDate: Date = Date() {
        didSet {
            postNotificationDidUpdateSelectedDate()
        }
    }
    
    func updateSelectedDate(_ date: Date) {
        selectedDate = date
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
