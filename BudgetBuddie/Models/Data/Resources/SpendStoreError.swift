//
//  SpendStoreError.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 1/3/26.
//

import Foundation

enum SpendStoreError: LocalizedError {
    case dayNotFound
    case itemsNotFound
    case monthsNotFound
    case previousMonthNotFound
    case unableToSaveItem
    case unableToDeleteItem
    case unableToSaveMonth
    case unableToPrepForMonth
    case unableToDeletePreviousMonthData
    case notImplemented(String)
    
    var errorDescription: String? {
        switch self {
        case .dayNotFound: "Could not find day."
        case .itemsNotFound: "Could not find items."
        case .monthsNotFound: "Could not find months."
        case .previousMonthNotFound: "Could not find previous month."
        case .unableToSaveItem: "Could not save item."
        case .unableToDeleteItem: "Could not delete item."
        case .unableToSaveMonth: "Could not save month."
        case .unableToPrepForMonth: "Could not prep for month."
        case .unableToDeletePreviousMonthData: "Could not delete previous month data."
        case .notImplemented(let value): "Not implemented: \(value)"
        }
    }
}
