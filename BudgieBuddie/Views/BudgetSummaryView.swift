//
//  BudgetSummaryView.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import SwiftUI

struct BudgetSummaryView: View {
    // Instance vars
    private let viewModel: BudgetSummaryViewModel
    
    // Constructors
    init(
        viewModel: BudgetSummaryViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: Spacing.1
        ) {
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
            
            HStack(
                spacing: Spacing.2
            ) {
                SpendTrendsView(
                    viewModel: viewModel.spendTrendsViewModel
                )
                Divider()
                CalendarView(
                    viewModel: viewModel.calendarViewModel
                )
                .frame(height: 300.0) // magic number matching SpendTrendsView height
            }
        }
        .padding(Padding.2)
        .roundedRectangleBackground(
            cornerRadius: CornerRadius.2,
            color: .backgroundSecondary
        )
    }
}

#Preview {
    BudgetSummaryView(
        viewModel: .mock()
    )
}
