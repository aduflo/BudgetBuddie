//
//  SettingsView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/23/25.
//

import SwiftUI

/** TODO:
 - settings for:
   - Daily allowance field / would update monthly too <-------------
   - Monthly allowance field / would update daily too
   - Tolerance treshold
 */

struct SettingsView: View {
    // Instance vars
    @State var monthlyAllowance: Decimal = 0.0
    @State var toleranceThreshold: Double = 0.0
    
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
                viewModel.postNotificationSettingsUpdated()
            }
            
            Slider(
                value: $toleranceThreshold,
                in: 0.0...1.0,
                step: 0.01,
                label: {
                    Text("Tolerance threshold")
                },
                minimumValueLabel: {
                    Text("0%")
                },
                maximumValueLabel: {
                    Text("100%")
                },
                onEditingChanged: { editing in
                    if editing == false {
                        viewModel.setToleranceThreshold(toleranceThreshold)
                        viewModel.postNotificationSettingsUpdated()
                    }
                }
            )
            Text(viewModel.displayToleranceThreshold) // FIXME: this is broken
        }
        .onAppear {
            monthlyAllowance = viewModel.monthlyAllowance
            toleranceThreshold = viewModel.toleranceThreshold
        }
    }
}

#Preview {
    SettingsView(
        monthlyAllowance: 0.0,
        toleranceThreshold: 0.0,
        viewModel: .mock()
    )
}
