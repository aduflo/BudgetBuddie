//
//  SpendRepository.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/27/25.
//

import Foundation

class SpendRepository {
    // Instance vars
    private(set) var spendService: SpendServiceable
    
    // Constructors
    init(
        spendService: SpendServiceable = PersistenceSpendService()
    ) {
        self.spendService = spendService
    }
}

// MARK: Public interface
extension SpendRepository {
    func saveSpendItem(_ spendItem: SpendItem) {
        backfillSpendDaysIfNeeded()
    }
}

// MARK: Private interface
private extension SpendRepository {
    func getSpendDayForDate(_ date: Date) {
        
    }
    
    func backfillSpendDaysIfNeeded() {
        // TODO: implement
        // check how many days have past since last spend day
        // create `n` days with zero spend up until today, if there was spend today
        // do this at beginning of saveSpendItem()
    }
}
