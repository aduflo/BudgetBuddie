//
//  SpendStoreError.swift
//  BirdsEye
//
//  Created by Adam Duflo on 1/3/26.
//

import Foundation

enum SpendStoreError: LocalizedError {
    case dayNotFound
    case itemsNotFound
    case monthsNotFound
    case monthNotFound
    case unableToSaveItem
    case unableToDeleteItem
    case unableToSaveMonth
    case unableToStageMonth
    case unableToDeleteStagedMonthData
    case notImplemented(String)
    
    var errorDescription: String? {
        switch self {
        case .dayNotFound: "Could not find day."
        case .itemsNotFound: "Could not find items."
        case .monthsNotFound: "Could not find months."
        case .monthNotFound: "Could not find month."
        case .unableToSaveItem: "Could not save item."
        case .unableToDeleteItem: "Could not delete item."
        case .unableToSaveMonth: "Could not save month."
        case .unableToStageMonth: "Could not stage month."
        case .unableToDeleteStagedMonthData: "Could not delete staged month data."
        case .notImplemented(let value): "Not implemented: \(value)"
        }
    }
}
