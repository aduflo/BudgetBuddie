//
//  BudgetListView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import SwiftUI

struct BudgetListView: View {
    let viewModel: BudgetListViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.items) { item in
                    BudgetListItemView(viewModel: item)
                }
            }
        }
        .frame(width: 160.0)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.green)
        )
    }
}

#Preview {
    BudgetListView(viewModel: .stub())
}
