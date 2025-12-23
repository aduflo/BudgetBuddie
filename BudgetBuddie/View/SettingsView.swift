//
//  SettingsView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/23/25.
//

import SwiftUI

/** TODO:
 - settings for:
   - Daily allowance field
   - Monthly allowance field
   - Tolerance treshold
 */

struct SettingsView: View {
    @Binding var monthlyAllowance: Decimal
    @Binding var toleranceTreshold: Double
    
    private var currencyFormat: Decimal.FormatStyle.Currency {
        .currency(code: CurrencyFormatter.shared.code)
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
            Slider( // FIXME: slider has no intervals.. fix
                value: $toleranceTreshold,
                in: 0...100,
                label: {
                    Text("Tolerance threshold")
                },
                onEditingChanged: { yar in
                    print("on tolerance changed: ")
                }
            )
        }
    }
}

#Preview {
    SettingsView(
        monthlyAllowance: .constant(2000),
        toleranceTreshold: .constant(0.0)
    )
}
