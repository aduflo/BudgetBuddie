//
//  CalenderServiceable.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import Foundation

protocol CalenderServiceable {
    func daysInMonth(_ date: Date) -> Int
    func currentMonthDay(_ date: Date) -> Int
}
