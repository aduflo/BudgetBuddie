//
//  BudgetView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import SwiftUI

struct BudgetView: View {
    let viewModel: BudgetViewModel
    
    var body: some View {
        VStack {
            BudgetHeaderView()
            BudgetRundownView(
                viewModel: viewModel.rundownViewModel
            )
            BudgetListView(
                viewModel: viewModel.listViewModel
            )
        }
        .padding()
    }
}

#Preview {
    BudgetView(viewModel: .mock())
}
