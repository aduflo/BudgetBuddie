//
//  SpendItemView.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 12/28/25.
//

import SwiftUI

struct SpendItemView: View {
    // Instance vars
    @State private var viewModel: SpendItemViewModel
    @State private var amount: Decimal = 0.0
    @State private var note: String = ""
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
            headerView
            amountView
            noteView
            footerView
            Spacer() // to push everything to the top
        }
        .padding(Padding.2)
        .onAppear {
            amount = viewModel.amount
            note = viewModel.note
        }
    }
    
    var headerView: some View {
        VStack(
            spacing: Spacing.1
        ) {
            Text(viewModel.title)
                .font(.title)
                .foregroundStyle(.foregroundPrimary)
                .padding(Padding.1)
            
            Divider()
        }
    }
    
    var amountView: some View {
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
        .foregroundStyle(.foregroundPrimary)
    }
    
    var noteView: some View {
        VStack(
            alignment: .leading,
            spacing: Spacing.1
        ) {
            Text(Copy.note)
            TextField(
                Copy.noteTitleKey,
                text: $note
            )
            .textFieldStyle(.roundedBorder)
            .onChange(of: note, { _, newValue in
                viewModel.setNote(newValue)
            })
            .onSubmit {
                viewModel.setNote(note)
            }
        }
        .foregroundStyle(.foregroundPrimary)
    }
    
    var footerView: some View {
        HStack(
            spacing: Spacing.2
        ) {
            Group {
                if let requiredFieldWarningText = viewModel.requiredFieldWarningText {
                    Text(requiredFieldWarningText)
                } else if viewModel.error != nil {
                    Text(Copy.errorPleaseTryAgain)
                }
            }
            .foregroundStyle(.red)
            
            Spacer()
            
            if case .existing = viewModel.mode {
                Button(
                    TitleKey.Button.delete,
                    systemImage: SystemImage.trash,
                    action: { isDeleteConfirmationAlertPresented = true }
                )
                .buttonStyle(.circleSystemImage)
                .alert(
                    Copy.deleteAlertTitle,
                    isPresented: $isDeleteConfirmationAlertPresented
                ) {
                    Button(
                        Copy.cancel,
                        role: .cancel
                    ) {}
                    Button(
                        Copy.delete,
                        role: .destructive
                    ) {
                        if viewModel.deleteTapped() {
                            dismiss()
                        }
                    }
                }
            }
            Button(
                TitleKey.Button.save,
                systemImage: SystemImage.checkmark,
                action: {
                    if viewModel.saveTapped() {
                        dismiss()
                    }
                }
            )
            .buttonStyle(.circleSystemImage)
        }
        .padding(Padding.1)
    }
}

#Preview("Light Mode") {
    SpendItemView(
        viewModel: .mock()
    )
    .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    SpendItemView(
        viewModel: .mock()
    )
    .preferredColorScheme(.dark)
}
