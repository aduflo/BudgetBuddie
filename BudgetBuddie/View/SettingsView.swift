//
//  SettingsView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/23/25.
//

import SwiftUI

struct SettingsView: View {
    // Instance vars
    @State var monthlyAllowance: Decimal = 0.0
    @State var warningThreshold: Double = 0.0
    let viewModel: SettingsViewModel
    
    private var currencyFormat: Decimal.FormatStyle.Currency {
        .currency(code: viewModel.currencyFormatter.code)
    }
    
    var body: some View {
        VStack {
            TextField( // FIXME: this is very broken
                "Monthly allowance",
                value: $monthlyAllowance,
                format: currencyFormat
            )
            .textFieldStyle(.roundedBorder)
            .keyboardType(.decimalPad)
            .onSubmit {
                viewModel.setMonthlyAllowance(monthlyAllowance)
            }
            
            Slider(
                value: $warningThreshold,
                in: 0.0...1.0,
                step: 0.01,
                label: {
                    Text("Warning threshold")
                },
                minimumValueLabel: {
                    Text("0%")
                },
                maximumValueLabel: {
                    Text("100%")
                },
                onEditingChanged: { editing in
                    if editing == false { // only set when editing finishes
                        viewModel.setWarningThreshold(warningThreshold)
                    }
                }
            )
            Text("Warning threshold: \(warningThreshold.formatted(.percent))")
            Text("Determines when budget trend data shifts from 🟩 to 🟧.")
                .font(.footnote)
        }
        .onAppear {
            monthlyAllowance = viewModel.monthlyAllowance
            warningThreshold = viewModel.warningThreshold
        }
    }
}

#Preview {
    SettingsView(
        monthlyAllowance: 0.0,
        warningThreshold: 0.0,
        viewModel: .mock()
    )
}
