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
        VStack(
            alignment: .leading,
            spacing: 32.0
        ) {
            VStack(spacing: 8.0) {
                Text("Settings")
                    .font(.title)
                Divider()
            }
            
            VStack(
                alignment: .leading,
                spacing: 8.0
            ) {
                Text("Monthly allowance")
                TextField(
                    "Monthly allowance",
                    value: $monthlyAllowance,
                    format: currencyFormat
                )
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
                .onSubmit {
                    viewModel.setMonthlyAllowance(monthlyAllowance)
                }
            }
            
            VStack(
                alignment: .leading,
                spacing: 8.0
            ) {
                Text("Warning threshold: \(warningThreshold.formatted(.percent))")
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
                Text("Assists in budget evaluation, determining if our budget is in a state of acceptable, encroaching, or exceeded.")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
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
