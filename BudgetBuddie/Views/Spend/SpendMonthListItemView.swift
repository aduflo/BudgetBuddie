//
//  SpendMonthListItemView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 1/18/26.
//

import SwiftUI

struct SpendMonthListItemView: View {
    // Instance vars
    private let viewModel: SpendMonthListItemViewModel
    
    // Constructors
    init(
        viewModel: SpendMonthListItemViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(
            spacing: Spacing.zero
        ) {
            VStack(
                alignment: .leading,
                spacing: Spacing.1
            ) {
                Text(viewModel.displaySpend)
                    .font(.headline)
                // TODO: build view
//                VStack(
//                    alignment: .leading,
//                    spacing: Spacing.half
//                ) {
//                    Text(Copy.note)
//                        .font(.subheadline)
//                    Text(viewModel.displayAllowance)
//                        .font(.caption)
//                        .lineLimit(1)
//                        .truncationMode(.tail)
//                }
            }
            Spacer()
        }
        .padding(Padding.1)
        .roundedRectangleBackground(
            cornerRadius: CornerRadius.1,
            color: .white
        )
    }
}

#Preview {
    SpendMonthListItemView(
        viewModel: SpendMonthListItemViewModel(
            currencyFormatter: CurrencyFormatter(),
            spendMonth: .mock()
        )
    )
}
