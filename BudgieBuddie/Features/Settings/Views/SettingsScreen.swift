//
//  SettingsScreen.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 12/23/25.
//

import SwiftUI

struct SettingsScreen: View {
    // Instance vars
    @State private var screenModel: SettingsScreenModel
    @State private var monthlyAllowance: Decimal? = nil
    @State private var warningThreshold: Double = 0.0
    
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
            contentView
        }
        .padding(.top, Padding.2)
        .padding(.horizontal, Padding.2)
        .padding(.bottom, Padding.3)
        .ignoresSafeArea(.container, edges: .bottom)
        .onAppear {
            if screenModel.monthlyAllowance > 0.0 {
                monthlyAllowance = screenModel.monthlyAllowance
            }
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
    
    var contentView: some View {
        ScrollView(.vertical) {
            VStack(
                alignment: .leading,
                spacing: Spacing.4
            ) {
                defaultSpendTrendViewpointPickerView
                monthlyAllowanceView
                warningThresholdView
                versionView
            }
        }
        .scrollIndicators(.hidden)
    }
    
    var defaultSpendTrendViewpointPickerView: some View {
        VStack(
            alignment: .leading,
            spacing: Spacing.1
        ) {
            Text(Copy.defaultSpendTrendsViewpoint)
            
            Picker(
                TitleKey.Picker.spendTrendViewpoint,
                selection: $screenModel.defaultSpendTrendViewpoint
            ) {
                ForEach(SpendTrendViewpoint.allCases) { viewpoint in
                    Text(viewpoint.displayValue)
                        .tag(viewpoint)
                }
            }
            .pickerStyle(.segmented)
            
            Text(Copy.defaultSpendTrendsViewpointFootnote)
                .font(.footnote)
                .fixedSize(horizontal: false, vertical: true)
        }
        .foregroundStyle(.foregroundPrimary)
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
            
            Text(Copy.monthlyAllowanceFootnote)
                .font(.footnote)
                .fixedSize(horizontal: false, vertical: true)
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
                .fixedSize(horizontal: false, vertical: true)
        }
        .foregroundStyle(.foregroundPrimary)
    }
    
    var versionView: some View {
        Text(screenModel.displayVersion)
            .font(.caption)
            .foregroundStyle(.foregroundPrimary)
            .frame(maxWidth: .infinity)
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
