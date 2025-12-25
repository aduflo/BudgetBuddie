//
//  ContentView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import SwiftUI

struct ContentView: View {
    // Instance vars
    @Environment(\.settingsRepo) var settingsRepo
    
    var body: some View {
        BudgetView(
            viewModel: BudgetViewModel(
                rundownViewModel: BudgetRundownViewModel(
                    selectedDate: Date(),
                    dailyTrendViewModel: BudgetTrendViewModel(
                        title: "Daily",
                        currentSpend: 0,
                        maxSpend: 0,
                        settingsRepo: settingsRepo
                    ),
                    mtdTrendViewModel: BudgetTrendViewModel(
                        title: "Month-To-Date (MTD)",
                        currentSpend: 0,
                        maxSpend: 0,
                        settingsRepo: settingsRepo
                    ),
                    monthlyTrendViewModel: BudgetTrendViewModel(
                        title: "Monthly",
                        currentSpend: 0,
                        maxSpend: 0,
                        settingsRepo: settingsRepo
                    )
                ),
                listViewModel: BudgetListViewModel(items: []),
                settingsViewModel: SettingsViewModel(settingsRepo: settingsRepo)
            )
        )
    }
}

#Preview {
    ContentView()
}
