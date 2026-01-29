//
//  SpendMonthSummaryView.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/17/26.
//

import SwiftUI

struct SpendMonthSummaryView: View {
    // Instance vars
    @State var viewModel: SpendMonthSummaryViewModel
    
    var body: some View {
        VStack(
            spacing: Spacing.1
        ) {
            headerView
            contentView
            Spacer() // to push everything to the top
        }
        .padding(Padding.2)
        .onAppear {
            viewModel.reloadData()
        }
    }
    
    var headerView: some View {
        VStack(
            spacing: Spacing.1
        ) {
            Text(Copy.monthSummaryTitle)
                .font(.title)
                .padding(Padding.1)
            Divider()
        }
    }
    
    var contentView: some View {
        Group {
            if viewModel.error != nil {
                errorView
            } else {
                summaryView
            }
        }
    }
    
    var errorView: some View {
        Text(Copy.errorSomethingWentWrong)
            .font(.headline)
            .foregroundStyle(Color.red)
    }
    
    var summaryView: some View {
        VStack(
            spacing: Spacing.2
        ) {
            VStack(
                spacing: Spacing.1
            ) {
                Text(Copy.letsSeeHowWeDidThisMonth(viewModel.displayMonth))
                    .font(.headline)
                
                Text(viewModel.displaySpendDifference)
                    .foregroundStyle({
                        if viewModel.isSpendWithinBudget {
                            Color.green
                        } else {
                            Color.red
                        }
                    }())
                    .font(.largeTitle)
                
                HStack(
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
                }
            }
            
            Group {
                if viewModel.isSpendWithinBudget {
                    Text(Copy.greatJobLetsKeepItUp)
                } else {
                    Text(Copy.letsDoBetterThisMonth)
                }
            }
            .font(.title3)
        }
    }
}

#Preview("Happy State; Underspent") {
    SpendMonthSummaryView(
        viewModel: SpendMonthSummaryViewModel(
            spendRepository: {
                let spendRepository = MockSpendRepository()
                spendRepository.getMonth_returnValue = (
                    SpendMonth(
                        date: .distantPast,
                        spend: 13.37,
                        allowance: 1337
                    ),
                    nil
                )
                return spendRepository
            }(),
            currencyFormatter: CurrencyFormatter(),
            date: .distantPast
        )
    )
}

#Preview("Happy State; Overspent") {
    SpendMonthSummaryView(
        viewModel: SpendMonthSummaryViewModel(
            spendRepository: {
                let spendRepository = MockSpendRepository()
                spendRepository.getMonth_returnValue = (
                    SpendMonth(
                        date: .distantFuture,
                        spend: 9001,
                        allowance: 9000
                    ),
                    nil
                )
                return spendRepository
            }(),
            currencyFormatter: CurrencyFormatter(),
            date: .distantPast
        )
    )
}

#Preview("Error State") {
    SpendMonthSummaryView(
        viewModel: SpendMonthSummaryViewModel(
            spendRepository: {
                let spendRepository = MockSpendRepository()
                spendRepository.getMonth_returnValue = (nil, SpendRepositoryError.unableToCommitStagedMonth)
                return spendRepository
            }(),
            currencyFormatter: CurrencyFormatter(),
            date: .distantPast
        )
    )
}
