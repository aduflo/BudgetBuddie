//
//  SpendRepositoryError.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/20/26.
//

import Foundation

enum SpendRepositoryError: LocalizedError {
    case unableToCommitStagedMonth
    
    var errorDescription: String? {
        switch self {
        case .unableToCommitStagedMonth: "Could not commit staged month."
        }
    }
}
