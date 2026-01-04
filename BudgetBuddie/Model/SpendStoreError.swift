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
        // TODO: implement
        switch self {
        case .spendDayNotFound: nil
        case .spendItemsNotFound: nil
        case .unableToSaveItem: nil
        case .unableToDeleteItem: nil
        }
    }
    
    var failureReason: String? {
        // TODO: implement
        switch self {
        case .spendDayNotFound: nil
        case .spendItemsNotFound: nil
        case .unableToSaveItem: nil
        case .unableToDeleteItem: nil
        }
    }

    var recoverySuggestion: String? {
        // TODO: implement
        switch self {
        case .spendDayNotFound: nil
        case .spendItemsNotFound: nil
        case .unableToSaveItem: nil
        case .unableToDeleteItem: nil
        }
    }
    
    var helpAnchor: String? {
        // TODO: implement
        switch self {
        case .spendDayNotFound: nil
        case .spendItemsNotFound: nil
        case .unableToSaveItem: nil
        case .unableToDeleteItem: nil
        }
    }
}
