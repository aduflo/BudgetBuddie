//
//  SpendItemScreen.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 12/28/25.
//

import SwiftUI

struct SpendItemScreen: View {
    // Instance vars
    @State private var screenModel: SpendItemScreenModel
    @State private var amount: Decimal? = nil
    @State private var note: String = ""
    @State private var isDeleteConfirmationAlertPresented: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    // Constructors
    init(
        screenModel: SpendItemScreenModel
    ) {
        self.screenModel = screenModel
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
            if screenModel.amount > 0.0 {
                amount = screenModel.amount
            }
            note = screenModel.note
        }
    }
    
    var headerView: some View {
        VStack(
            spacing: Spacing.1
        ) {
            Text(screenModel.title)
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
                format: screenModel.currencyFormatter.decimalFormatStyle
            )
            .textFieldStyle(.roundedBorder)
            .keyboardType(.decimalPad)
            .onChange(of: amount, { _, newValue in
                screenModel.setAmount(newValue)
            })
            .onSubmit {
                screenModel.setAmount(amount)
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
                screenModel.setNote(newValue)
            })
            .onSubmit {
                screenModel.setNote(note)
            }
        }
        .foregroundStyle(.foregroundPrimary)
    }
    
    var footerView: some View {
        HStack(
            spacing: Spacing.2
        ) {
            Group {
                if let requiredFieldWarningText = screenModel.requiredFieldWarningText {
                    Text(requiredFieldWarningText)
                } else if screenModel.error != nil {
                    Text(Copy.errorPleaseTryAgain)
                }
            }
            .foregroundStyle(.red)
            
            Spacer()
            
            if case .existing = screenModel.mode {
                CircleButton(
                    systemImage: SystemImage.trash,
                    action: { isDeleteConfirmationAlertPresented = true }
                )
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
                        if screenModel.delete() {
                            dismiss()
                        }
                    }
                }
            }
            
            CircleButton(
                systemImage: SystemImage.checkmark,
                action: {
                    if screenModel.save() {
                        dismiss()
                    }
                }
            )
        }
        .padding(Padding.1)
    }
}

#Preview("Light Mode") {
    SpendItemScreen(
        screenModel: .mock()
    )
    .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    SpendItemScreen(
        screenModel: .mock()
    )
    .preferredColorScheme(.dark)
}
