//
//  SpendMonthSummaryViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 1/17/26.
//

import Foundation

// TODO: button things up here

@Observable
class SpendMonthSummaryViewModel {
    // Instance vars
    private let spendRepository: SpendRepositable
    private let month: Int
    private let year: Int
    
    private(set) var spendMonth: SpendMonth?
    private(set) var error: Error? = nil
    
    // Constructors
    init(
        spendRepository: SpendRepositable,
        month: Int,
        year: Int
    ) {
        self.spendRepository = spendRepository
        self.month = month
        self.year = year
    }
}

// MARK: Public interface
extension SpendMonthSummaryViewModel {
    func reloadData() {
        // attempt to extract spendMonth via params
        do {
            error = nil
            spendMonth = try spendRepository.getMonth(
                month: month,
                year: year
            )
        } catch {
            self.error = error
        }
        
        // digest outcome; continue if spendMonth extracted + no error
        guard let spendMonth, error == nil else {
            return
        }
        
        // update view attributes since we have spend month
        
    }
    
    var displayText: String {
        "Month: \(spendMonth?.month) Year: \(spendMonth?.year) Spend: \(spendMonth?.spend) Allowance: \(spendMonth?.allowance)"
    }
}

// MARK: Private interface
private extension SpendMonthSummaryViewModel {
    //
}
