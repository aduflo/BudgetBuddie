//
//  AppIconIdea.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 1/23/26.
//

import SwiftUI

struct AppIconIdea: View {
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: Spacing.zero
        ) {
            HStack {
                Text("BUD")
                Spacer()
            }
            HStack {
                Spacer()
                Text("BUD")
            }
        }
        .font(.title3)
        .fontWeight(.bold)
        .frame(width: 50.0, height: 50.0)
        .padding(Padding.2)
        .roundedRectangleBackground(
            cornerRadius: CornerRadius.2,
            color: .yellow,
            strokeColor: .brown,
            strokeWidth: 4.0
        )
    }
}

#Preview {
    AppIconIdea()
}
