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
            // TODO: add ability to delete spend item
            // TODO: add ability to edit spend item?? or just delete and readd workflow... maybe just this for v1
            // if edit, will show SpendItemView?
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
                            SpendListItemView(viewModel: item)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SpendListView(viewModel: .mock())
}
