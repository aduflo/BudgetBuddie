//
//  SpendMonthSummaryScreen.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/17/26.
//

import SwiftUI

struct SpendMonthSummaryScreen: View {
    // Instance vars
    @State var screenModel: SpendMonthSummaryScreenModel
    
    var body: some View {
        VStack(
            spacing: Spacing.1
        ) {
            headerView
            contentView
            Spacer() // to push everything to the top
        }
        .padding(Padding.2)
    }
    
    var headerView: some View {
        VStack(
            spacing: Spacing.1
        ) {
            Text(Copy.monthSummaryTitle)
                .font(.title)
                .foregroundStyle(.foregroundPrimary)
                .padding(Padding.1)
            
            Divider()
        }
    }
    
    var contentView: some View {
        Group {
            if screenModel.error != nil {
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
                Text(Copy.letsSeeHowWeDidThisMonth(screenModel.displayMonth))
                    .font(.headline)
                    .foregroundStyle(.foregroundPrimary)
                
                Text(screenModel.displayBudgetDifference)
                    .font(.largeTitle)
                    .foregroundStyle({
                        if screenModel.isWithinBudget {
                            Color.green
                        } else {
                            Color.red
                        }
                    }())
                
                HStack(
                    spacing: Spacing.2
                ) {
                    VStack(
                        alignment: .leading,
                        spacing: Spacing.half
                    ) {
                        Text(Copy.spend)
                            .font(.subheadline)
                        Text(screenModel.displaySpend)
                    }
                    
                    VStack(
                        alignment: .leading,
                        spacing: Spacing.half
                    ) {
                        Text(Copy.allowance)
                            .font(.subheadline)
                        Text(screenModel.displayAllowance)
                    }
                }
                .foregroundStyle(.foregroundPrimary)
            }
            
            Group {
                if screenModel.isWithinBudget {
                    Text(Copy.greatJobLetsKeepItUp)
                } else {
                    Text(Copy.letsDoBetterThisMonth)
                }
            }
            .font(.title3)
            .foregroundStyle(.foregroundPrimary)
        }
    }
}

#Preview("Light Mode") {
    SpendMonthSummaryScreen(
        screenModel: .mock()
    )
    .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    SpendMonthSummaryScreen(
        screenModel: .mock()
    )
    .preferredColorScheme(.dark)
}

#Preview("Happy State; Underspent") {
    SpendMonthSummaryScreen(
        screenModel: SpendMonthSummaryScreenModel(
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
    SpendMonthSummaryScreen(
        screenModel: SpendMonthSummaryScreenModel(
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
    SpendMonthSummaryScreen(
        screenModel: SpendMonthSummaryScreenModel(
            spendRepository: {
                let spendRepository = MockSpendRepository()
                spendRepository.getMonth_returnValue = (nil, SpendRepositoryError.getMonthFailed)
                return spendRepository
            }(),
            currencyFormatter: CurrencyFormatter(),
            date: .distantPast
        )
    )
}
