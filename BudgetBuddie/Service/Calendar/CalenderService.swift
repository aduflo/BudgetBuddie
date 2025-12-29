//
//  CalenderService.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import Foundation

class CalenderService: CalenderServiceable {
    func daysInMonth(_ date: Date) -> Int {
        let calendar = Calendar.current
        let monthRange = calendar.range(of: .day, in: .month, for: date)
        return monthRange?.count ?? 0
    }
    
    func currentMonthDay(_ date: Date) -> Int {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents(in: TimeZone.current, from: date)
        return dateComponents.day ?? 0
    }
}
