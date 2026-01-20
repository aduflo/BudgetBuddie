//
//  SettingsView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/23/25.
//

import SwiftUI

struct SettingsView: View {
    // Instance vars
    private let viewModel: SettingsViewModel
    @State var monthlyAllowance: Decimal = 0.0
    @State var warningThreshold: Double = 0.0
    
    // Constructors
    init(
        viewModel: SettingsViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: Spacing.3
        ) {
            headerView
            monthlyAllowanceView
            warningThresholdView
            Spacer() // to push everything to the top
        }
        .padding(Padding.2)
        .onAppear {
            monthlyAllowance = viewModel.monthlyAllowance
            warningThreshold = viewModel.warningThreshold
        }
    }
    
    var headerView: some View {
        VStack(
            spacing: Spacing.1
        ) {
            Text(Copy.settings)
                .font(.title)
                .padding(Padding.1)
            Divider()
        }
    }
    
    var monthlyAllowanceView: some View {
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
    }
    
    var warningThresholdView: some View {
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
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    SettingsView(
        viewModel: .mock()
    )
}
