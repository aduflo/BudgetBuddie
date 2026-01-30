//
//  AppIcon.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/23/26.
//

import SwiftUI

struct AppIcon: View {
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: Spacing.zero
        ) {
            Text(Copy.appNamePrefix)
            Text(Copy.appNameSuffix)
        }
        .foregroundStyle(.white)
        .font(.body)
        .fontWeight(.heavy)
        .frame(width: 64.0, height: 64.0)
        .padding(Padding.1)
        .roundedRectangleBackground(
            cornerRadius: CornerRadius.2,
            color: .backgroundApp
        )
    }
}

#Preview {
    AppIcon()
}
