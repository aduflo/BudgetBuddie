//
//  BudgetView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import SwiftUI

struct BudgetView: View {
    // Instance vars
    @State private var presentSettings = false
    
    let viewModel: BudgetViewModel
    
    var body: some View {
        VStack {
            BudgetHeaderView()
            BudgetRundownView(
                viewModel: viewModel.rundownViewModel
            )
            .onReceive(
                NotificationCenter.default.publisher(for: .SettingsTapped),
                perform: { _ in
                    Task {
                        await MainActor.run {
                            presentSettings.toggle()
                        }
                    }
                }
            )
            .sheet(isPresented: $presentSettings) {
                SettingsView(
                    viewModel: viewModel.settingsViewModel
                )
                .presentationDetents([.height(200.0)])
            }
            BudgetListView(
                viewModel: viewModel.listViewModel
            )
        }
        .padding()
    }
}

#Preview {
    BudgetView(viewModel: .mock())
}
