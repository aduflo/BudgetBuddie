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
        VStack(
            spacing: Spacing.1
        ) {
            headerView
            contentView
        }
        .padding(Padding.2)
        .roundedRectangleBackground(
            cornerRadius: CornerRadius.2,
            color: .gray.opacity(0.25)
        )
        .onAppear {
            viewModel.reloadData()
        }
        .onReceive(
            Publishers.Merge(
                NotificationCenter.default.publisher(for: .SelectedDateDidUpdate),
                NotificationCenter.default.publisher(for: .SpendRepositoryDidUpdateItem)
            ),
            perform: { _ in
                Task { await MainActor.run {
                    viewModel.reloadData()
                }}
            }
        )
    }
    
    var headerView: some View {
        HStack {
            Text(viewModel.title)
                .font(.title2)
            Spacer()
            Button(
                ButtonKey.newSpendItem,
                systemImage: SystemImage.plus,
                action: { viewModel.newSpendItemTapped() }
            )
            .buttonStyle(.circleSystemImage)
        }
    }
    
    var contentView: some View {
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
                        ForEach(viewModel.listItemViewModels) { viewModel in
                            SpendListItemView(
                                viewModel: viewModel
                            )
                            .onTapGesture {
                                self.viewModel.spendItemTapped(viewModel.spendItem)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SpendListView(
        viewModel: .mock()
    )
}
