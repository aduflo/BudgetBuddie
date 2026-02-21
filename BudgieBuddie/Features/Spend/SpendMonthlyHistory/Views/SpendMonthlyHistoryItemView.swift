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
                        if viewModel.isWithinBudget {
                            SystemImage.chartLineUptrendXyaxis
                        } else {
                            SystemImage.chartLineDowntrendXyaxis
                        }
                    }())
                    Text(viewModel.displayBudgetDifference)
                }
                .foregroundStyle({
                    if viewModel.isWithinBudget {
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
            spendRepository: {
                let dayId = UUID()
                let day = SpendDay(
                    id: dayId,
                    date: Date(),
                    items: [SpendItem(
                        dayId: dayId,
                        amount: 2_000,
                        note: nil
                    )],
                    isCommitted: false
                )
                let spendRepository = MockSpendRepository()
                spendRepository.getDayForId_returnValue = (day, nil)
                return spendRepository
            }(),
            currencyFormatter: CurrencyFormatter(),
            spendMonth: SpendMonth(
                date: Date(),
                dayIds: [UUID()],
                allowance: 55_432
            )
        )
    )
    .frame(height: 120.0)
}

#Preview("Big Deficit") {
    SpendMonthlyHistoryItemView(
        viewModel: SpendMonthlyHistoryItemViewModel(
            spendRepository: {
                let dayId = UUID()
                let day = SpendDay(
                    id: dayId,
                    date: Date(),
                    items: [SpendItem(
                        dayId: dayId,
                        amount: 55_432,
                        note: nil
                    )],
                    isCommitted: false
                )
                let spendRepository = MockSpendRepository()
                spendRepository.getDayForId_returnValue = (day, nil)
                return spendRepository
            }(),
            currencyFormatter: CurrencyFormatter(),
            spendMonth: SpendMonth(
                date: Date(),
                dayIds: [UUID()],
                allowance: 2_000
            )
        )
    )
    .frame(height: 120.0)
}
