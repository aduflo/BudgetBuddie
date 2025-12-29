//
//  SpendDay.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/27/25.
//

import Foundation
//import SwiftData
//
//@Model
//class SpendDay {
struct SpendDay {
    // Instance vars
    let id: UUID
    let date: Date
    let itemIds: [UUID]
    let isWithinBudget: Bool
}
