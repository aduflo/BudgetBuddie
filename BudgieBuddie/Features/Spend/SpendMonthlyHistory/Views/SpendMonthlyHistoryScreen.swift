//
//  SpendMonthlyHistoryScreen.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/18/26.
//

import SwiftUI

struct SpendMonthlyHistoryScreen: View {
    // Instance vars
    @State var screenModel: SpendMonthlyHistoryScreenModel
    
    var body: some View {
        VStack(
            spacing: Spacing.3
        ) {
            headerView
            sortView
            contentView
        }
        .padding(.top, Padding.2)
        .padding(.horizontal, Padding.2)
    }
    
    var headerView: some View {
        VStack(
            spacing: Spacing.1
        ) {
            Text(Copy.monthlyHistoryTitle)
                .font(.title)
                .foregroundStyle(.foregroundPrimary)
                .padding(Padding.1)
            Divider()
        }
    }
    
    var sortView: some View {
        VStack(
            alignment: .leading,
            spacing: Spacing.1
        ) {
            Picker(
                TitleKey.Picker.monthAttribute,
                selection: $screenModel.monthSortAttributeSelection
            ) {
                ForEach(SpendMonthlyHistorySortAttribute.allCases) { option in
                    Text(option.displayValue)
                }
            }
            
            Picker(
                TitleKey.Picker.order,
                selection: $screenModel.sortOrderSelection
            ) {
                let options: [SortOrder] = [
                    .forward,
                    .reverse
                ]
                ForEach(options, id: \.self) { option in
                    Text(screenModel.sortOrderDisplayValue(option))
                }
            }
        }
        .pickerStyle(.segmented)
        .foregroundStyle(.foregroundPrimary)
    }
    
    var contentView: some View {
        Group {
            if screenModel.error != nil {
                VStack {
                    errorView
                    Spacer() // to push everything to the top
                }
            } else if screenModel.listItemViewModels.isEmpty {
                VStack {
                    emptyView
                    Spacer() // to push everything to the top
                }
            } else {
                listView
                    .frame(maxHeight: .infinity)
            }
        }
    }
    
    var errorView: some View {
        VStack(
            spacing: Spacing.1
        ) {
            Text(Copy.errorPleaseTryAgain)
                .font(.headline)
                .foregroundStyle(Color.red)
            
            CircleButton(
                systemImage: SystemImage.arrowClockwise,
                action: {
                    screenModel.reloadData()
                }
            )
        }
    }
    
    var emptyView: some View {
        Text(Copy.emptyMonthlyHistory)
            .font(.footnote)
            .foregroundStyle(.foregroundPrimary)
            .multilineTextAlignment(.center)
    }
    
    var listView: some View {
        ScrollView(.vertical) {
            VStack(
                alignment: .leading,
                spacing: Spacing.1
            ) {
                ForEach(screenModel.listItemViewModels) { listItemViewModel in
                    SpendMonthlyHistoryItemView(
                        viewModel: listItemViewModel
                    )
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview("Light Mode") {
    SpendMonthlyHistoryScreen(
        screenModel: SpendMonthlyHistoryScreenModel(
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
    )
    .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    SpendMonthlyHistoryScreen(
        screenModel: SpendMonthlyHistoryScreenModel(
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
    )
    .preferredColorScheme(.dark)
}
