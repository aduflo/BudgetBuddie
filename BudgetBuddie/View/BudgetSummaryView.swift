//
//  BudgetSummaryView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import SwiftUI

struct BudgetSummaryView: View { // TODO: consider rename
    // Instance vars
    let viewModel: BudgetSummaryViewModel
    
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
                Spacer()
                Button(
                    "settings",
                    systemImage: SystemImage.gear,
                    action: { viewModel.settingsTapped() }
                )
                .labelStyle(.iconOnly)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.circle)
                .tint(.white)
                .foregroundStyle(.black)
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
            color: .gray.opacity(0.25)
        )
    }
}

#Preview {
    BudgetSummaryView(viewModel: .mock())
}
