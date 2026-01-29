//
//  AppIcon.swift
//  BirdsEye
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
        .frame(width: 56.0, height: 56.0)
        .padding(Padding.1)
        .roundedRectangleBackground(
            cornerRadius: CornerRadius.2,
            color: .blue
        )
    }
}

#Preview {
    AppIcon()
}
