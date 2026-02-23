//
//  MonthSpendCalculator.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 2/20/26.
//

import Foundation

// TODO: needs tests
enum MonthSpendCalculator {
    static func calculateSpend(
        month: SpendMonth,
        spendRepository: any SpendRepositable
    ) throws -> Decimal {
        let days = try month.dayIds.map { try spendRepository.getDay(id: $0) }
        let dayItems = days.map { $0.items }
        let items = dayItems.flatMap { $0 }
        let spend = items.reduce(0.0, { $0 + $1.amount })
        return spend
    }
}
