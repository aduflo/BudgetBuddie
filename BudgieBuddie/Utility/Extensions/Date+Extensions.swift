//
//  DateFormatter.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/4/26.
//

import Foundation

extension Date {
    var monthDayString: String {
        formatted(.dateTime.day(.twoDigits).month(.twoDigits))
    }
    
    var monthDayYearString: String {
        formatted(.dateTime.day(.twoDigits).month(.twoDigits).year(.defaultDigits))
    }
    
    var monthYearString: String {
        formatted(.dateTime.month(.wide).year(.defaultDigits))
    }
    
    var monthLongString: String {
        formatted(.dateTime.month(.wide))
    }
    
    func isSameDayAs(_ date: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: date)
    }
}
