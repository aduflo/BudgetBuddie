//
//  SpendRepositoryError.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 1/20/26.
//

import Foundation

enum SpendRepositoryError: LocalizedError {
    case initialSetupFailed
    case standardSetupFailed
    case getItemsFailed
    case saveItemFailed
    case deleteItemFailed
    case getDayFailed
    case getAllMonthsFailed
    case getMonthFailed
    case commitStagedMonthFailed
    
    var errorDescription: String? {
        switch self {
        case .initialSetupFailed: "Could not complete initial setup."
        case .standardSetupFailed: "Could not complete standard setup."
        case .getItemsFailed: "Could not get items."
        case .saveItemFailed: "Could not save item."
        case .deleteItemFailed: "Could not delete item."
        case .getDayFailed: "Could not get day."
        case .getAllMonthsFailed: "Could not get all months."
        case .getMonthFailed: "Could not get month."
        case .commitStagedMonthFailed: "Could not commit staged month."
        }
    }
}
