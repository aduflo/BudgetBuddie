//
//  SpendStoreError.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 1/3/26.
//

import Foundation

enum SpendStoreError: LocalizedError {
    case dayNotFound
    case daysNotFound
    case itemNotFound
    case itemsNotFound
    case monthsNotFound
    case monthNotFound
    case unableToSaveItem
    case unableToDeleteItem
    case unableToSaveMonth
    case unableToStageMonth
    case notImplemented(String)
    
    var errorDescription: String? {
        switch self {
        case .dayNotFound: "Could not find day."
        case .daysNotFound: "Could not find days."
        case .itemNotFound: "Could not find item."
        case .itemsNotFound: "Could not find items."
        case .monthsNotFound: "Could not find months."
        case .monthNotFound: "Could not find month."
        case .unableToSaveItem: "Could not save item."
        case .unableToDeleteItem: "Could not delete item."
        case .unableToSaveMonth: "Could not save month."
        case .unableToStageMonth: "Could not stage month."
        case .notImplemented(let value): "Not implemented: \(value)"
        }
    }
}
