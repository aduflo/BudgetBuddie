//
//  SpendMonthListView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 1/18/26.
//

import SwiftUI

struct SpendMonthListView: View {
    // Instance vars
    @State var viewModel: SpendMonthListViewModel
    
    var body: some View {
        // TODO: build view
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
            Text(Copy.history)
                .font(.title)
                .padding(Padding.1)
            Divider()
        }
    }
    
    var contentView: some View {
        Group {
            if viewModel.error != nil {
                errorView
            } else if viewModel.listItemViewModels.isEmpty {
                emptyView
            } else {
                listView
            }
        }
        .padding(Padding.2)
    }
    
    var errorView: some View {
        // TODO: determine if make into reusable component, given this was a C+P
        VStack(
            spacing: Spacing.1
        ) {
            Text(Copy.errorFetchingItems) // TODO: update copy for relevance
                .font(.headline)
                .foregroundStyle(Color.red)
            Button(
                ButtonKey.reload,
                systemImage: SystemImage.arrowClockwise,
                action: {
                    viewModel.reloadData()
                }
            )
            .buttonStyle(.circleSystemImage)
        }
    }
    
    var emptyView: some View {
        // TODO: build proper no-months-yet experience
        Text("empty oh no")
    }
    
    var listView: some View {
        ScrollView {
            VStack(
                alignment: .leading,
                spacing: Spacing.1
            ) {
                ForEach(viewModel.listItemViewModels) { listItemViewModel in
                    SpendMonthListItemView(
                        viewModel: listItemViewModel
                    )
                }
            }
        }
    }
}

#Preview {
    SpendMonthListView(
        viewModel: SpendMonthListViewModel(
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter()
        )
    )
}
