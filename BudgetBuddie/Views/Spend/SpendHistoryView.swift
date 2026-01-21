//
//  SpendHistoryView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 1/18/26.
//

import SwiftUI

struct SpendHistoryView: View {
    // Instance vars
    @State var viewModel: SpendHistoryViewModel
    
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
            viewModel.reloadData()
        }
    }
    
    var headerView: some View {
        VStack(
            spacing: Spacing.1
        ) {
            Text(Copy.spendHistoryTitle)
                .font(.title)
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
                selection: $viewModel.monthSortAttributeSelection
            ) {
                ForEach(SpendMonthSortAttribute.allCases) { option in
                    Text(viewModel.monthAttributeSortDisplayValue(option))
                }
            }
            Picker(
                TitleKey.Sort.order,
                selection: $viewModel.sortOrderSelection
            ) {
                let options: [SortOrder] = [
                    .forward,
                    .reverse
                ]
                ForEach(options, id: \.self) { option in
                    Text(viewModel.sortOrderDisplayValue(option))
                }
            }
        }
        .pickerStyle(.segmented)
    }
    
    var contentView: some View {
        Group {
            if viewModel.error != nil {
                VStack {
                    errorView
                    Spacer() // to push everything to the top
                }
            } else if viewModel.listItemViewModels.isEmpty {
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
                    viewModel.reloadData()
                }
            )
            .buttonStyle(.circleSystemImage)
        }
    }
    
    var emptyView: some View {
        Text(Copy.noRecordedHistory)
            .font(.headline)
    }
    
    var listView: some View {
        ScrollView {
            VStack(
                alignment: .leading,
                spacing: Spacing.1
            ) {
                ForEach(viewModel.listItemViewModels) { listItemViewModel in
                    SpendHistoryItemView(
                        viewModel: listItemViewModel
                    )
                }
            }
        }
    }
}

#Preview {
    SpendHistoryView(
        viewModel: SpendHistoryViewModel(
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
    )
}
