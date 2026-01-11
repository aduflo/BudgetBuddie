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
            if viewModel.error != nil {
                VStack(
                    spacing: Spacing.1
                ) {
                    Text(Copy.errorFetchingItems)
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
                HStack {
                    Text(Copy.goodJobSaving)
                        .font(.headline)
                    Spacer()
                }
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
                        ForEach(viewModel.listItemViewModels) { listItemViewModel in
                            SpendListItemView(
                                viewModel: listItemViewModel
                            )
                            .onTapGesture {
                                viewModel.spendItemTapped(listItemViewModel.spendItem)
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
