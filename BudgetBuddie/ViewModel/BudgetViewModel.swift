//
//  BudgetViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

@Observable
class BudgetViewModel {
    // Instance vars
    private(set) var rundownViewModel: BudgetRundownViewModel
    private(set) var listViewModel: BudgetListViewModel
    private(set) var settingsViewModel: SettingsViewModel
    
    // Constructors
    init(
        rundownViewModel: BudgetRundownViewModel,
        listViewModel: BudgetListViewModel,
        settingsViewModel: SettingsViewModel,
    ) {
        self.rundownViewModel = rundownViewModel
        self.listViewModel = listViewModel
        self.settingsViewModel = settingsViewModel
    }
}

// MARK: - Mocks
extension BudgetViewModel {
    static func mock() -> BudgetViewModel {
        BudgetViewModel(
            rundownViewModel: .mock(),
            listViewModel: .mock(),
            settingsViewModel: .mock()
        )
    }
}
