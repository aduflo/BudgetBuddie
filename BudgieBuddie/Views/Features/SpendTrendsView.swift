//
//  SpendTrendsView.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 12/30/25.
//

import SwiftUI
import Combine

struct SpendTrendsView: View {
    // Instance vars
    private let viewModel: SpendTrendsViewModel
    
    // Constructors
    init(
        viewModel: SpendTrendsViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: Spacing.1
        ) {
            Text(Copy.spendTrends)
                .font(.headline)
                .foregroundStyle(.foregroundPrimary)
            
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
                color: .backgroundPrimary
            )
        }
        .onAppear {
            viewModel.reloadData()
        }
        .onReceive(
            Publishers.Merge3(
                NotificationCenter.default.publisher(for: .SettingsDidUpdate),
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
}

#Preview {
    SpendTrendsView(
        viewModel: .mock()
    )
}
