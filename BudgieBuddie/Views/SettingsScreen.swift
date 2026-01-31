//
//  SettingsScreen.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 12/23/25.
//

import SwiftUI

struct SettingsScreen: View {
    // Instance vars
    private let screenModel: SettingsScreenModel
    @State var monthlyAllowance: Decimal = 0.0
    @State var warningThreshold: Double = 0.0
    
    // Constructors
    init(
        viewModel: SettingsScreenModel
    ) {
        self.screenModel = viewModel
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
            monthlyAllowance = screenModel.monthlyAllowance
            warningThreshold = screenModel.warningThreshold
        }
    }
    
    var headerView: some View {
        VStack(
            spacing: Spacing.1
        ) {
            Text(Copy.settingsTitle)
                .font(.title)
                .foregroundStyle(.foregroundPrimary)
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
                format: screenModel.currencyFormatter.decimalFormatStyle
            )
            .textFieldStyle(.roundedBorder)
            .keyboardType(.decimalPad)
            .onChange(of: monthlyAllowance, { oldValue, newValue in
                screenModel.setMonthlyAllowance(monthlyAllowance)
            })
            .onSubmit {
                screenModel.setMonthlyAllowance(monthlyAllowance)
            }
        }
        .foregroundStyle(.foregroundPrimary)
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
                        screenModel.setWarningThreshold(warningThreshold)
                    }
                }
            )
            Text(Copy.warningThresholdFootnote)
                .font(.footnote)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
        .foregroundStyle(.foregroundPrimary)
    }
}

#Preview("Light Mode") {
    SettingsScreen(
        viewModel: .mock()
    )
    .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    SettingsScreen(
        viewModel: .mock()
    )
    .preferredColorScheme(.dark)
}
