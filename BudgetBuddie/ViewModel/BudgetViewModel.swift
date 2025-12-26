//
//  BudgetViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

class BudgetViewModel {
    // Instance vars
    let rundownViewModel: BudgetRundownViewModel
    let listViewModel: BudgetListViewModel
    let settingsViewModel: SettingsViewModel
    
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
