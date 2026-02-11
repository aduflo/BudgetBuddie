//
//  SpendMonthlyHistoryItemView.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/18/26.
//

import SwiftUI

struct SpendMonthlyHistoryItemView: View {
    // Instance vars
    private let viewModel: SpendMonthlyHistoryItemViewModel
    
    // Constructors
    init(
        viewModel: SpendMonthlyHistoryItemViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(
            spacing: Spacing.half
        ) {
            contentView
        }
        .padding(.vertical, Padding.2)
        .padding(.horizontal, Padding.3)
        .roundedRectangleBackground(
            cornerRadius: CornerRadius.2,
            color: .backgroundPrimary
        )
    }
    
    var contentView: some View {
        HStack(
            spacing: Spacing.zero
        ) {
            VStack(
                alignment: .leading,
                spacing: Spacing.zero
            ) {
                VStack(
                    alignment: .leading,
                    spacing: Spacing.half
                ) {
                    Text(Copy.spend)
                        .font(.subheadline)
                    Text(viewModel.displaySpend)
                }
                
                Spacer()
                
                VStack(
                    alignment: .leading,
                    spacing: Spacing.half
                ) {
                    Text(Copy.allowance)
                        .font(.subheadline)
                    Text(viewModel.displayAllowance)
                }
            }
            .foregroundStyle(.foregroundPrimary)
            
            Spacer()
            
            VStack(
                alignment: .trailing,
                spacing: Spacing.zero
            ) {
                Text(viewModel.displayDate)
                    .font(.title3)
                    .foregroundStyle(.foregroundPrimary)
                
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
                    Text(viewModel.displaySpendDifference)
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
}

#Preview("Big Savings") {
    SpendMonthlyHistoryItemView(
        viewModel: SpendMonthlyHistoryItemViewModel(
            currencyFormatter: CurrencyFormatter(),
            spendMonth: SpendMonth(
                date: Date(),
                spend: 2000,
                allowance: 55_432
            )
        )
    )
    .frame(height: 120.0)
}

#Preview("Big Deficit") {
    SpendMonthlyHistoryItemView(
        viewModel: SpendMonthlyHistoryItemViewModel(
            currencyFormatter: CurrencyFormatter(),
            spendMonth: SpendMonth(
                date: Date(),
                spend: 55_432,
                allowance: 2000
            )
        )
    )
    .frame(height: 120.0)
}
