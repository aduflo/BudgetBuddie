//
//  DateFormatter.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/4/26.
//

import Foundation

extension Date {
    var timeString: String {
        formatted(date: .omitted, time: .standard)
    }
    
    var monthDayString: String {
        formatted(.dateTime.day(.twoDigits).month(.twoDigits))
    }
    
    var monthDayYearString: String {
        formatted(.dateTime.day(.twoDigits).month(.twoDigits).year(.defaultDigits))
    }
    
    var monthLongString: String {
        formatted(.dateTime.month(.wide))
    }
}
