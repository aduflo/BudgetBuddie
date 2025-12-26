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
                    dailyTrendViewModel: BudgetTrendViewModel(
                        title: "Daily",
                        currentSpend: 0,
                        maxSpend: 0,
                        settingsService: settingsService
                    ),
                    mtdTrendViewModel: BudgetTrendViewModel(
                        title: "Month-To-Date (MTD)",
                        currentSpend: 0,
                        maxSpend: 0,
                        settingsService: settingsService
                    ),
                    monthlyTrendViewModel: BudgetTrendViewModel(
                        title: "Monthly",
                        currentSpend: 0,
                        maxSpend: 0,
                        settingsService: settingsService
                    )
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
