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
            Text(Copy.appName)
                .font(.largeTitle)
            Image(systemName: SystemImage.dollarsignBankBuilding)
                .resizable()
                .frame(width: 32.0, height: 32.0)
        }
        .padding()
        .roundedRectangleBackground(
            cornerRadius: CornerRadius.2,
            color: .yellow,
            strokeColor: .brown,
            strokeWidth: 2.0
        )
    }
}

#Preview {
    BudgetBuddieBannerView()
}
