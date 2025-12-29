//
//  HomeViewModel.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import Foundation

@Observable
class HomeViewModel {
    // Instance vars
    let rundownViewModel: BudgetRundownViewModel
    let settingsViewModel: SettingsViewModel
    let spendViewModel: SpendViewModel
    
    // Constructors
    init(
        rundownViewModel: BudgetRundownViewModel,
        settingsViewModel: SettingsViewModel,
        spendViewModel: SpendViewModel
    ) {
        self.rundownViewModel = rundownViewModel
        self.settingsViewModel = settingsViewModel
        self.spendViewModel = spendViewModel
    }
}


// MARK: - Mocks
extension HomeViewModel {
    static func mock() -> HomeViewModel {
        HomeViewModel(
            rundownViewModel: .mock(),
            settingsViewModel: .mock(),
            spendViewModel: .mock()
        )
    }
}
