//
//  SpendSummaryView.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import SwiftUI

struct SpendSummaryView: View {
    // Instance vars
    private let viewModel: SpendSummaryViewModel
    @State private var spendTrendsViewSize: CGSize = .zero
    
    // Constructors
    init(
        viewModel: SpendSummaryViewModel
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
        .padding(Padding.2)
        .roundedRectangleBackground(
            cornerRadius: CornerRadius.2,
            color: .backgroundSecondary
        )
    }
    
    var headerView: some View {
        HStack {
            Text(Copy.summary)
                .font(.title2)
                .foregroundStyle(.foregroundPrimary)
            
            Spacer()
            
            Button(
                TitleKey.Button.settings,
                systemImage: SystemImage.gear,
                action: { viewModel.settingsTapped() }
            )
            .buttonStyle(.circleSystemImage)
        }
    }
    
    var contentView: some View {
        HStack(
            spacing: Spacing.2
        ) {
            spendTrendsView
            Divider()
            calendarView
        }
    }
    
    var spendTrendsView: some View {
        SpendTrendsView(
            viewModel: viewModel.spendTrendsViewModel
        )
        .sizePreferenceKeyed { spendTrendsViewSize = $0 }
    }
    
    var calendarView: some View {
        CalendarView(
            viewModel: viewModel.calendarViewModel
        )
        .frame(
            height: spendTrendsViewSize.height
        )
    }
}

#Preview {
    SpendSummaryView(
        viewModel: .mock()
    )
}
