//
//  MonthDay.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import Foundation

struct MonthDay: Identifiable {
    // Instance vars
    let day: Int
    let date: Date
    
    // Identifiable
    let id = UUID()
}
