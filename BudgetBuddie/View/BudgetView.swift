//
//  BudgetView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import SwiftUI

struct BudgetView: View {
    let viewModel: BudgetViewModel
    
    @State private var presentSettings = false
    
    var body: some View {
        VStack {
            BudgetHeaderView()
            BudgetRundownView(
                viewModel: viewModel.rundownViewModel
            )
            .onSettingsTapped {
                presentSettings.toggle()
            }
            .sheet(isPresented: $presentSettings) {
                SettingsView(
                    monthlyAllowance: .constant(2000),
                    toleranceTreshold: .constant(0.0)
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
