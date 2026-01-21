//
//  BudgetBuddieBannerView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import SwiftUI

struct BudgetBuddieBannerView: View {
    var body: some View {
        Text(Copy.appName)
            .font(.largeTitle)
            .padding(Padding.2)
            .roundedRectangleBackground(
                cornerRadius: CornerRadius.2,
                color: .yellow,
                strokeColor: .brown,
                strokeWidth: StrokeWidth.2
            )
    }
}

#Preview {
    BudgetBuddieBannerView()
}
