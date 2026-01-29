//
//  MonthDay.swift
//  BirdsEye
//
//  Created by Adam Duflo on 12/28/25.
//

import Foundation

struct MonthDay {
    // Instance vars
    let day: Int
    let date: Date
}

// MARK: - Mocks
extension MonthDay {    
    static func mockPast() -> MonthDay {
        MonthDay(
            day: 01,
            date: Date.distantPast
        )
    }
    
    static func mockPresent() -> MonthDay {
        MonthDay(
            day: 12,
            date: Date()
        )
    }
    
    static func mockFuture() -> MonthDay {
        MonthDay(
            day: 23,
            date: Date.distantFuture
        )
    }
}
