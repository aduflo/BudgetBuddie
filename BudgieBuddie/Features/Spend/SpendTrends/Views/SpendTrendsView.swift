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
            headerView
            contentView
        }
        .onReceive(
            NotificationCenter.default.publisher(for: .SettingsDidUpdateDefaultSpendTrendViewpoint),
            perform: { _ in
                Task { await MainActor.run {
                    viewModel.useDefaultViewpoint()
                    viewModel.reloadData()
                }}
            }
        )
        .onReceive(
            Publishers.Merge5(
                NotificationCenter.default.publisher(for: .SettingsDidUpdateMonthlyAllowance),
                NotificationCenter.default.publisher(for: .SettingsDidUpdateWarningThreshold),
                NotificationCenter.default.publisher(for: .CalendarServiceDidUpdateTodayDate),
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
        Text(Copy.spendTrends)
            .font(.headline)
            .foregroundStyle(.foregroundPrimary)
    }
    
    var contentView: some View {
        ZStack(
            alignment: .topTrailing
        ) {
            trendsView
            cycleButton
        }
        .padding(Padding.2)
        .roundedRectangleBackground(
            cornerRadius: CornerRadius.2,
            color: .backgroundPrimary
        )
    }
    
    var trendsView: some View {
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
    }
    
    var cycleButton: some View {
        Button {
            viewModel.cycleViewpoint()
            viewModel.reloadData()
        } label: {
            Image(
                systemName: SystemImage.rectangle2Swap
            )
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 16.0)
            .foregroundStyle(.foregroundPrimary)
        }
    }
}

#Preview {
    SpendTrendsView(
        viewModel: .mock()
    )
}
