//
//  SpendStoreError.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 1/3/26.
//

import Foundation

enum SpendStoreError: LocalizedError {
    case spendDayNotFound
    case spendItemsNotFound
    case unableToSaveItem
    case unableToDeleteItem
    
    var errorDescription: String? {
        switch self {
        case .spendDayNotFound: "Could not find spend day."
        case .spendItemsNotFound: "Could not find spend items."
        case .unableToSaveItem: "Could not save spend item."
        case .unableToDeleteItem: "Could not delete spend item."
        }
    }
}
