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
        Group {
            if viewModel.error != nil {
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
            } else if viewModel.listItemViewModels.isEmpty {
                // TODO: build proper no-months-yet experience
                Text("empty oh no")
            } else {
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
        .onAppear {
            viewModel.reloadData()
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
