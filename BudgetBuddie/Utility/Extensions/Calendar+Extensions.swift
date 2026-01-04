//
//  Calendar+Extensions.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 1/4/26.
//

import Foundation

extension Calendar {
    func monthDatesFor(_ date: Date) -> [Date] {
        let dayRange = range(
            of: .day,
            in: .month,
            for: date
        )
        var dateComponents = dateComponents(
            [.day, .month, .year],
            from: date
        )
        return dayRange?.compactMap {
            dateComponents.day = $0
            return self.date(from: dateComponents)
        } ?? []
    }
}
