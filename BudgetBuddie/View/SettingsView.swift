//
//  SettingsView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/23/25.
//

import SwiftUI

struct SettingsView: View {
    // Instance vars
    let viewModel: SettingsViewModel
    @State var monthlyAllowance: Decimal = 0.0
    @State var warningThreshold: Double = 0.0
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: Spacing.2
        ) {
            VStack(
                spacing: Spacing.1
            ) {
                Text(Copy.settings)
                    .font(.title)
                Divider()
            }
            
            VStack(
                alignment: .leading,
                spacing: Spacing.1
            ) {
                Text(Copy.monthlyAllowance)
                TextField(
                    Copy.monthlyAllowanceTitleKey,
                    value: $monthlyAllowance,
                    format: viewModel.currencyFormatter.decimalFormatStyle
                )
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
                .onSubmit {
                    viewModel.setMonthlyAllowance(monthlyAllowance)
                }
            }
            
            VStack(
                alignment: .leading,
                spacing: Spacing.1
            ) {
                Text(Copy.warningThreshold(warningThreshold.formatted(.percent)))
                Slider(
                    value: $warningThreshold,
                    in: 0.0...1.0,
                    step: 0.01,
                    label: {
                        Text(Copy.warningThreshold)
                    },
                    minimumValueLabel: {
                        Text(Copy.zeroPercent)
                    },
                    maximumValueLabel: {
                        Text(Copy.oneHundredPercent)
                    },
                    onEditingChanged: { editing in
                        if editing == false { // only set when editing finishes
                            viewModel.setWarningThreshold(warningThreshold)
                        }
                    }
                )
                Text(Copy.warningThresholdFootnote)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(Padding.2)
        .onAppear {
            monthlyAllowance = viewModel.monthlyAllowance
            warningThreshold = viewModel.warningThreshold
        }
    }
}

#Preview {
    SettingsView(
        viewModel: .mock(),
        monthlyAllowance: 0.0,
        warningThreshold: 0.0
    )
}
