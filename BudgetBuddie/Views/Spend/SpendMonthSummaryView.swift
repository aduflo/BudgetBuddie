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
        Text(viewModel.displayText)
        .onAppear {
            viewModel.reloadData()
        }
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
