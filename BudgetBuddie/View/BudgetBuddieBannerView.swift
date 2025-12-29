//
//  BudgetBuddieBannerView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import SwiftUI

struct BudgetBuddieBannerView: View {
    var body: some View {
        HStack {
            Text("BudgetBuddie")
                .font(.largeTitle)
            Image(systemName: "dollarsign.bank.building")
                .resizable()
                .frame(width: 32.0, height: 32.0)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.yellow)
                .strokeBorder(
                    .brown,
                    lineWidth: 2.0
                )
        )
    }
}

#Preview {
    BudgetBuddieBannerView()
}
