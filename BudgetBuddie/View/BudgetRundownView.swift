//
//  BudgetRundownView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import SwiftUI

struct BudgetRundownView: View { // TODO: consider rename
    // Instance vars
    let viewModel: BudgetRundownViewModel
    
    // Constructors
    init(
        viewModel: BudgetRundownViewModel
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
                alignment: .top,
                spacing: Spacing.1
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
    BudgetRundownView(viewModel: .mock())
}
