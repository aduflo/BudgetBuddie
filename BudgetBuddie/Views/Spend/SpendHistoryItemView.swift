//
//  SpendHistoryItemView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 1/18/26.
//

import SwiftUI

struct SpendHistoryItemView: View {
    // Instance vars
    private let viewModel: SpendHistoryItemViewModel
    
    // Constructors
    init(
        viewModel: SpendHistoryItemViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: Spacing.half
        ) {
            headerView
            contentView
        }
        .padding(.vertical, Padding.2)
        .padding(.horizontal, Padding.3)
        .roundedRectangleBackground(
            cornerRadius: CornerRadius.2,
            color: .white
        )
    }
    
    var headerView: some View {
        Text(viewModel.displayDate)
            .font(.headline)
    }
    
    var contentView: some View {
        HStack(
            alignment: .bottom,
            spacing: Spacing.2
        ) {
            VStack(
                alignment: .leading,
                spacing: Spacing.half
            ) {
                Text(Copy.spend)
                    .font(.subheadline)
                Text(viewModel.displaySpend)
            }
            VStack(
                alignment: .leading,
                spacing: Spacing.half
            ) {
                Text(Copy.allowance)
                    .font(.subheadline)
                Text(viewModel.displayAllowance)
            }
            
            Spacer()
            
            VStack(
                alignment: .trailing,
                spacing: Spacing.half
            ) {
                Image(systemName: {
                    if viewModel.isSpendWithinBudget {
                        SystemImage.chartLineUptrendXyaxis
                    } else {
                        SystemImage.chartLineDowntrendXyaxis
                    }
                }())
                Text(viewModel.displayDifference)
            }
            .foregroundStyle({
                if viewModel.isSpendWithinBudget {
                    Color.green
                } else {
                    Color.red
                }
            }())
        }
    }
}

#Preview {
    SpendHistoryItemView(
        viewModel: SpendHistoryItemViewModel(
            currencyFormatter: CurrencyFormatter(),
            spendMonth: .mock()
        )
    )
}
