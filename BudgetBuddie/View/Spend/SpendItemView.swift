//
//  SpendItemView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import SwiftUI

struct SpendItemView: View {
    // Instance vars
    let viewModel: SpendItemViewModel
    @State var amount: Decimal = 0.0
    @State var description: String = ""
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: Spacing.2
        ) {
            VStack(
                spacing: Spacing.1
            ) {
                Text(viewModel.title)
                    .font(.title)
                Divider()
            }
            
            VStack(
                alignment: .leading,
                spacing: Spacing.1
            ) {
                Text(Copy.amount)
                TextField(
                    Copy.amountTitleKey,
                    value: $amount,
                    format: viewModel.currencyFormatter.decimalFormatStyle
                )
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
                .onSubmit {
                    viewModel.setAmount(amount)
                }
            }
            
            VStack(
                alignment: .leading,
                spacing: Spacing.1
            ) {
                Text(Copy.description)
                TextField(
                    Copy.descriptionTitleKey,
                    text: $description
                )
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    viewModel.setDescription(description)
                }
            }
            
            HStack {
                Spacer()
                Button(
                    "save",
                    systemImage: SystemImage.checkmark,
                    action: { viewModel.saveTapped() }
                )
                .circleBackground()
            }
        }
        .padding(Padding.2)
        .onAppear {
            amount = viewModel.amount
        }
    }
}

#Preview {
    SpendItemView(
        viewModel: .mock()
    )
}
