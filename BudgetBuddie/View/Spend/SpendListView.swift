//
//  SpendListView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import SwiftUI

struct SpendListView: View {
    // Instance vars
    let viewModel: SpendListViewModel
    
    var body: some View {
        // TODO: if no models, need an empty state
        VStack(
            alignment: .leading
        ) {
            Text("Spend items")
                .font(.headline)
            
            ScrollView {
                VStack(
                    alignment: .leading,
                    spacing: 8.0
                ) {
                    ForEach(viewModel.items) { item in
                        SpendListItemView(viewModel: item)
                    }
                }
            }
        }
    }
}

#Preview {
    SpendListView(viewModel: .mock())
}
