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
                Text(warningThresholdFootnote)
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

// Components
extension SettingsView {
    var warningThresholdFootnote: AttributedString {
        let current = Copy.current
        let spendTrends = Copy.spendTrends
        let green = "green"
        let orange = "orange"
        var attributedString = AttributedString("The warning threshold determines when to warn that you've exceeded your comfortable spending allotment. When you've exceeded your comfortable spending allotment, the \(current) amounts under \(spendTrends) will change from \(green) to \(orange).")
        
        if let currentRange = attributedString.range(of: current) {
            attributedString[currentRange].inlinePresentationIntent = .stronglyEmphasized
        }
        if let spendingTrendsRange = attributedString.range(of: spendTrends) {
            attributedString[spendingTrendsRange].inlinePresentationIntent = .stronglyEmphasized
        }
        if let greenRange = attributedString.range(of: green) {
            attributedString[greenRange].foregroundColor = .green
        }
        if let orangeRange = attributedString.range(of: orange) {
            attributedString[orangeRange].foregroundColor = .orange
        }
        
        return attributedString
    }
}

#Preview {
    SettingsView(
        viewModel: .mock(),
        monthlyAllowance: 0.0,
        warningThreshold: 0.0
    )
}
