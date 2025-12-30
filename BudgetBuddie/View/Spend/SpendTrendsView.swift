//
//  SpendTrendsView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/30/25.
//

import SwiftUI
import Combine

struct SpendTrendsView: View {
    // Instance vars
    let viewModel: SpendTrendsViewModel
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: Spacing.1
        ) {
            Text(Copy.spendTrends)
                .font(.headline)
            VStack(
                alignment: .leading,
                spacing: Spacing.1
            ) {
                SpendTrendView(
                    viewModel: viewModel.dailyTrendViewModel
                )
                Divider()
                SpendTrendView(
                    viewModel: viewModel.mtdTrendViewModel
                )
                Divider()
                SpendTrendView(
                    viewModel: viewModel.monthlyTrendViewModel
                )
            }
            .padding(Padding.2)
            .roundedRectangleBackground(
                cornerRadius: CornerRadius.2,
                color: .white
            )
        }
        .onAppear {
            viewModel.reloadData()
        }
        .onReceive(
            Publishers.Merge(
                NotificationCenter.default.publisher(for: .SettingsUpdated),
                NotificationCenter.default.publisher(for: .SelectedDateUpdated)
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
    SpendTrendsView(
        viewModel: .mock()
    )
}
