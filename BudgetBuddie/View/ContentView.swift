//
//  ContentView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import SwiftUI

struct ContentView: View {
    // Instance vars
    @Environment(\.settingsService) var settingsService
    
    var body: some View {
        BudgetView(
            viewModel: BudgetViewModel(
                rundownViewModel: BudgetRundownViewModel(
                    selectedDate: Date(),
                    settingsService: settingsService
                ),
                listViewModel: BudgetListViewModel(items: []),
                settingsViewModel: SettingsViewModel(settingsService: settingsService)
            )
        )
    }
}

#Preview {
    ContentView()
}
