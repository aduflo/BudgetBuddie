//
//  SpendMonthlyHistoryScreenModel.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/18/26.
//

import Foundation

@Observable
class SpendMonthlyHistoryScreenModel {
    // Instance vars
    private let spendRepository: SpendRepositable
    private let currencyFormatter: CurrencyFormatter
    
    private(set) var listItemViewModels: [SpendMonthlyHistoryItemViewModel] = []
    private(set) var error: Error? = nil
    
    var monthSortAttributeSelection: SpendMonthlyHistorySortAttribute = .date {
        didSet {
            reloadData()
        }
    }
    var sortOrderSelection: SortOrder = .reverse {
        didSet {
            reloadData()
        }
    }
    
    // Constructors
    init(
        spendRepository: SpendRepositable,
        currencyFormatter: CurrencyFormatter
    ) {
        self.spendRepository = spendRepository
        self.currencyFormatter = currencyFormatter
        reloadData()
    }
}

// MARK: Public interface
extension SpendMonthlyHistoryScreenModel {
    func reloadData() {
        do {
            listItemViewModels = try listItemViewModelsBuilder()
            error = nil
        } catch {
            listItemViewModels = []
            self.error = error
        }
    }
    
    func sortOrderDisplayValue(_ sortOrder: SortOrder) -> String {
        switch monthSortAttributeSelection {
        case .date:
            switch sortOrder {
            case .forward: Copy.oldest
            case .reverse: Copy.newest
            }
        case .spend:
            switch sortOrder {
            case .forward: Copy.lessSpend
            case .reverse: Copy.moreSpend
            }
        }
    }
}

// MARK: Private interface
private extension SpendMonthlyHistoryScreenModel {
    func listItemViewModelsBuilder() throws -> [SpendMonthlyHistoryItemViewModel] {
        // get allMonths
        let allMonths = try spendRepository.getAllMonths()
        
        // sort
        let sorted = switch monthSortAttributeSelection {
        case .date:
            sortByDate(allMonths)
        case .spend:
            sortBySpend(allMonths)
        }
        
        // map and return
        return sorted.map {
            SpendMonthlyHistoryItemViewModel(
                spendRepository: spendRepository,
                currencyFormatter: currencyFormatter,
                spendMonth: $0
            )
        }
    }
    
    func sortByDate(_ months: [SpendMonth]) -> [SpendMonth] {
        months.sorted(
            using: SortDescriptor<SpendMonth>(\.date, order: sortOrderSelection)
        )
    }
    
    func sortBySpend(_ months: [SpendMonth]) -> [SpendMonth] {
        typealias MonthSpendDuo = (id: UUID, spend: Decimal)
        var monthSpendDuos: [MonthSpendDuo] = []
        for month in months {
            do {
                let spend = try MonthSpendCalculator.calculateSpend(
                    month: month,
                    spendRepository: spendRepository
                )
                monthSpendDuos.append((
                    id: month.id,
                    spend: spend
                ))
            } catch {}
        }
        let sortedMonthSpendDuos = monthSpendDuos.sorted(
            using: SortDescriptor<MonthSpendDuo>(\.spend, order: sortOrderSelection)
        )
        let sortedMonths = sortedMonthSpendDuos.compactMap { duo in
            months.first { month in
                month.id == duo.id
            }
        }
        return sortedMonths
    }
}

// MARK: - Mocks
extension SpendMonthlyHistoryScreenModel {
    static func mock() -> SpendMonthlyHistoryScreenModel {
        SpendMonthlyHistoryScreenModel(
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
    }
}
