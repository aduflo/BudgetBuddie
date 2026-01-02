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
        if viewModel.items.isEmpty {
            // FIXME: proper empty state
            Text("empty, danggg")
        } else {
            VStack(
                alignment: .leading,
                spacing: Spacing.1
            ) {
                Text(Copy.spendItems)
                    .font(.headline)
                
                ScrollView {
                    VStack(
                        alignment: .leading,
                        spacing: Spacing.1
                    ) {
                        ForEach(viewModel.items) { item in
                            SpendListItemView(
                                viewModel: item
                            )
                            .onTapGesture {
                                viewModel.spendItemTapped(item.spendItem)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SpendListView(
        viewModel: .mock()
    )
}
