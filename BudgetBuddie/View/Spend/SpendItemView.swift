//
//  SpendItemView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import SwiftUI

struct SpendItemView: View {
    // Instance vars
    @State private var viewModel: SpendItemViewModel
    @State private var amount: Decimal = 0.0
    @State private var description: String = ""
    @State private var isDeleteConfirmationAlertPresented: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    // Constructors
    init(
        viewModel: SpendItemViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: Spacing.3
        ) {
            VStack(
                spacing: Spacing.1
            ) {
                Text(viewModel.title)
                    .font(.title)
                    .padding(Padding.1)
                Divider()
            }
            
            VStack(
                alignment: .leading,
                spacing: Spacing.1
            ) {
                Text(Copy.required(Copy.amount))
                TextField(
                    Copy.amountTitleKey,
                    value: $amount,
                    format: viewModel.currencyFormatter.decimalFormatStyle
                )
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
                .onChange(of: amount, { _, newValue in
                    viewModel.setAmount(newValue)
                })
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
                .onChange(of: description, { _, newValue in
                    viewModel.setDescription(newValue)
                })
                .onSubmit {
                    viewModel.setDescription(description)
                }
            }
            
            HStack(
                spacing: Spacing.2
            ) {
                if let requiredFieldWarningText = viewModel.requiredFieldWarningText {
                    Text(requiredFieldWarningText)
                        .foregroundStyle(Color.red)
                }
                Spacer()
                if case .existing = viewModel.mode {
                    Button(
                        "delete",
                        systemImage: "trash",
                        action: { isDeleteConfirmationAlertPresented = true }
                    )
                    .buttonStyle(.circleSystemImage)
                    .alert(
                        Copy.deleteAlertTitle,
                        isPresented: $isDeleteConfirmationAlertPresented
                    ) {
                        Button(Copy.cancel, role: .cancel) {}
                        Button(Copy.delete) {
                            viewModel.deleteTapped()
                            dismiss()
                        }
                    }
                }
                Button(
                    "save",
                    systemImage: SystemImage.checkmark,
                    action: { viewModel.saveTapped() }
                )
                .buttonStyle(.circleSystemImage)
            }
            .padding(Padding.1)
            Spacer() // to push everything to the top
        }
        .padding(Padding.2)
        .onAppear {
            amount = viewModel.amount
            description = viewModel.description
        }
    }
}

#Preview {
    SpendItemView(
        viewModel: .mock()
    )
}
