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
    private let date: Date
    
    private(set) var spendMonth: SpendMonth?
    private(set) var error: Error? = nil
    
    // Constructors
    init(
        spendRepository: SpendRepositable,
        date: Date
    ) {
        self.spendRepository = spendRepository
        self.date = date
    }
}

// MARK: Public interface
extension SpendMonthSummaryViewModel {
    func reloadData() {
        // attempt to extract spendMonth via params
        do {
            error = nil
            spendMonth = try spendRepository.getMonth(
                date: date
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
        "Date: \(date.monthDayYearString) Spend: \(spendMonth?.spend) Allowance: \(spendMonth?.allowance)"
    }
}

// MARK: Private interface
private extension SpendMonthSummaryViewModel {
    //
}
