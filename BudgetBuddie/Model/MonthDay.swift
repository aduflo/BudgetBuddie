//
//  MonthDay.swift
//  BudgetBuddie
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
    static func mock() -> MonthDay {
        MonthDay(
            day: 25,
            date: Date()
        )
    }
}
