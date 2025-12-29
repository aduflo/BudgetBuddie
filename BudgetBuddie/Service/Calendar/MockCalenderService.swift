//
//  MockCalenderService.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import Foundation

class MockCalenderService: CalenderServiceable {
    func daysInMonth(_ date: Date) -> Int {
        31
    }
    
    func currentMonthDay(_ date: Date) -> Int {
        3
    }
}
