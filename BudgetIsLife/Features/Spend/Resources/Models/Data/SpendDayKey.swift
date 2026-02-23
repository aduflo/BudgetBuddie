//
//  SpendDayKey.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 1/10/26.
//

import Foundation

struct SpendDayKey {
    // Instance vars
    let value: String
    
    // Constructors
    init(_ date: Date) {
        value = date.monthDayYearString
    }
}
