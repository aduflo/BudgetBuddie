//
//  SpendHistoryScreen.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/18/26.
//

import SwiftUI

struct SpendHistoryScreen: View {
    // Instance vars
    @State var screenModel: SpendHistoryScreenModel
    
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
        .onAppear {
            screenModel.reloadData()
        }
    }
    
    var headerView: some View {
        VStack(
            spacing: Spacing.1
        ) {
            Text(Copy.historyTitle)
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
                TitleKey.Sort.monthAttribute,
                selection: $screenModel.monthSortAttributeSelection
            ) {
                ForEach(SpendMonthSortAttribute.allCases) { option in
                    Text(screenModel.monthAttributeSortDisplayValue(option))
                        .foregroundStyle(.foregroundPrimary)
                }
            }
            
            Picker(
                TitleKey.Sort.order,
                selection: $screenModel.sortOrderSelection
            ) {
                let options: [SortOrder] = [
                    .forward,
                    .reverse
                ]
                ForEach(options, id: \.self) { option in
                    Text(screenModel.sortOrderDisplayValue(option))
                        .foregroundStyle(.foregroundPrimary)
                }
            }
        }
        .pickerStyle(.segmented)
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
            Button(
                TitleKey.Button.reload,
                systemImage: SystemImage.arrowClockwise,
                action: {
                    screenModel.reloadData()
                }
            )
            .buttonStyle(.circleSystemImage)
        }
    }
    
    var emptyView: some View {
        Text(Copy.noRecordedHistory)
            .font(.headline)
            .foregroundStyle(.foregroundPrimary)
    }
    
    var listView: some View {
        ScrollView {
            VStack(
                alignment: .leading,
                spacing: Spacing.1
            ) {
                ForEach(screenModel.listItemViewModels) { listItemViewModel in
                    SpendHistoryItemView(
                        viewModel: listItemViewModel
                    )
                }
            }
        }
    }
}

#Preview("Light Mode") {
    SpendHistoryScreen(
        screenModel: SpendHistoryScreenModel(
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
    )
    .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    SpendHistoryScreen(
        screenModel: SpendHistoryScreenModel(
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
    )
    .preferredColorScheme(.dark)
}
