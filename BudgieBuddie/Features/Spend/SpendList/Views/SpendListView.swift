//
//  SpendListView.swift
//  BudgieBuddie
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
            color: .backgroundSecondary
        )
        .onAppear {
            viewModel.reloadData()
        }
        .onReceive(
            Publishers.Merge(
                NotificationCenter.default.publisher(for: .CalendarServiceDidUpdateSelectedDate),
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
                .foregroundStyle(.foregroundPrimary)
            
            Spacer()
            
            CircleButton(
                systemImage: SystemImage.plus,
                action: { viewModel.newSpendItemTapped() }
            )
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
                    viewModel.reloadData()
                }
            )
        }
    }
    
    var emptyView: some View {
        HStack {
            Text(Copy.emptySpendList)
                .font(.headline)
                .foregroundStyle(.foregroundPrimary)
            
            Spacer()
        }
    }
    
    var listView: some View {
        VStack(
            alignment: .leading,
            spacing: Spacing.1
        ) {
            Text(Copy.spendItems)
                .font(.headline)
                .foregroundStyle(.foregroundPrimary)
            
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

#Preview {
    SpendListView(
        viewModel: .mock()
    )
}
