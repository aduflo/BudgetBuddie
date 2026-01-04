//
//  SpendListView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import SwiftUI
import Combine

struct SpendListView: View {
    // Instance vars
    private let viewModel: SpendListViewModel
    
    // Constructors
    init(
        viewModel: SpendListViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group {
            if viewModel.items.isEmpty {
                Text(Copy.goodJobSaving)
            } else {
                VStack(
                    alignment: .leading,
                    spacing: Spacing.1
                ) {
                    Text(Copy.spendItems)
                        .font(.headline)
                    
                    VStack(
                        alignment: .leading,
                        spacing: Spacing.1
                    ) {
                        ForEach(viewModel.items) { item in
                            SpendListItemView(
                                viewModel: item
                            )
                            .onTapGesture {
                                viewModel.spendItemTapped(item.spendItem)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.reloadData()
        }
        .onReceive(
            Publishers.Merge(
                NotificationCenter.default.publisher(for: .SelectedDateUpdated),
                NotificationCenter.default.publisher(for: .SpendRepositoryUpdated)
            ),
            perform: { _ in
                Task { await MainActor.run {
                    viewModel.reloadData()
                }}
            }
        )
    }
}

#Preview {
    SpendListView(
        viewModel: .mock()
    )
}
