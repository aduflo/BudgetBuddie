//
//  SpendHistoryViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 1/18/26.
//

import Foundation

@Observable
class SpendHistoryViewModel {
    // Instance vars
    private let spendRepository: SpendRepositable
    private let currencyFormatter: CurrencyFormatter
    
    private(set) var listItemViewModels: [SpendHistoryItemViewModel] = []
    private(set) var error: Error? = nil
    
    var monthSortAttributeSelection: SpendMonthSortAttribute = .date {
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
    }
}

// MARK: Public interface
extension SpendHistoryViewModel {
    func reloadData() {
        do {
            error = nil
            listItemViewModels = try listItemViewModelsBuilder()
        } catch {
            self.error = error
            listItemViewModels = []
        }
    }
    
    func monthAttributeSortDisplayValue(_ monthAttribute: SpendMonthSortAttribute) -> String {
        switch monthAttribute {
        case .date: Copy.date
        case .spend: Copy.spend
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
private extension SpendHistoryViewModel {
    func listItemViewModelsBuilder() throws -> [SpendHistoryItemViewModel] {
        // get allMonths
        let allMonths = try spendRepository.getAllMonths()
        
        // sort
        var sortDescriptors: [SortDescriptor<SpendMonth>] = []
        switch monthSortAttributeSelection {
        case .date:
            // TODO: revisit to see if we want to leverage SpendMonth.date once it's included on model
            sortDescriptors.append(SortDescriptor<SpendMonth>(\.year, order: sortOrderSelection))
            sortDescriptors.append(SortDescriptor<SpendMonth>(\.month, order: sortOrderSelection))
        case .spend:
            sortDescriptors.append(SortDescriptor<SpendMonth>(\.spend, order: sortOrderSelection))
        }
        let sorted = allMonths.sorted(using: sortDescriptors)
        
        // map and return
        return sorted.map {
            SpendHistoryItemViewModel(
                currencyFormatter: currencyFormatter,
                spendMonth: $0
            )
        }
    }
}

// MARK: - Mocks
extension SpendHistoryViewModel {
    static func mock() -> SpendHistoryViewModel {
        SpendHistoryViewModel(
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
    }
}
