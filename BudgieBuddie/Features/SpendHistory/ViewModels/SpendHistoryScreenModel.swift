//
//  SpendHistoryScreenModel.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/18/26.
//

import Foundation

@Observable
class SpendHistoryScreenModel {
    // Instance vars
    private let spendRepository: SpendRepositable
    private let currencyFormatter: CurrencyFormatter
    
    private(set) var listItemViewModels: [SpendHistoryItemViewModel] = []
    private(set) var error: Error? = nil
    
    var monthSortAttributeSelection: SpendHistorySortAttribute = .date {
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
extension SpendHistoryScreenModel {
    func reloadData() {
        do {
            listItemViewModels = try listItemViewModelsBuilder()
            error = nil
        } catch {
            listItemViewModels = []
            self.error = error
        }
    }
    
    func monthAttributeSortDisplayValue(_ monthAttribute: SpendHistorySortAttribute) -> String {
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
private extension SpendHistoryScreenModel {
    func listItemViewModelsBuilder() throws -> [SpendHistoryItemViewModel] {
        // get allMonths
        let allMonths = try spendRepository.getAllMonths()
        
        // sort
        var sortDescriptors: [SortDescriptor<SpendMonth>] = []
        switch monthSortAttributeSelection {
        case .date:
            sortDescriptors.append(SortDescriptor<SpendMonth>(\.date, order: sortOrderSelection))
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
extension SpendHistoryScreenModel {
    static func mock() -> SpendHistoryScreenModel {
        SpendHistoryScreenModel(
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
    }
}
