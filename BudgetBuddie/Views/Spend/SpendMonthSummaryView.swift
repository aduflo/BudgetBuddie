//
//  SpendMonthSummaryView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 1/17/26.
//

import SwiftUI

// TODO: button things up here

struct SpendMonthSummaryView: View {
    // Instance vars
    @State var viewModel: SpendMonthSummaryViewModel
    
    var body: some View {
        // TODO: build view
        VStack(
            spacing: Spacing.1
        ) {
            headerView
            contentView
        }
        .padding(Padding.2)
        .onAppear {
            viewModel.reloadData()
        }
    }
    
    var headerView: some View {
        VStack(
            spacing: Spacing.1
        ) {
            Text(Copy.history)
                .font(.title)
                .padding(Padding.1)
            Divider()
        }
    }
    
    var contentView: some View {
        Text(viewModel.displayText)
    }
}

#Preview {
    SpendMonthSummaryView(
        viewModel: SpendMonthSummaryViewModel(
            spendRepository: MockSpendRepository(),
            month: 01,
            year: 2026
        )
    )
}
