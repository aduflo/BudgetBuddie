//
//  CalendarService.swift
//  BirdsEye
//
//  Created by Adam Duflo on 12/28/25.
//

import Foundation

class CalendarService: CalendarServiceable {
    // CalendarServiceable    
    private(set) var selectedDate: Date = Date() {
        didSet {
            postNotificationSelectedDateUpdated()
        }
    }
    
    func updateSelectedDate(_ date: Date) {
        selectedDate = date
    }
}

// MARK: Private interface
private extension CalendarService {
    func postNotificationSelectedDateUpdated() {
        NotificationCenter.default.post(.SelectedDateDidUpdate)
    }
}
