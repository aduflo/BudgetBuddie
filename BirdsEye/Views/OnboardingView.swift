//
//  OnboardingView.swift
//  BirdsEye
//
//  Created by Adam Duflo on 1/23/26.
//

import SwiftUI

struct OnboardingView: View {
    // Instance vars
    private let viewModel = OnboardingViewModel()
    
    var body: some View {
        VStack(
            spacing: Spacing.2
        ) {
            AppIcon()
            
            ScrollView(.vertical) {
                Text(Copy.onboardingDescription)
                    .font(.body)
            }
            .scrollIndicators(.automatic)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
        .padding(Padding.3)
        .onAppear {
            viewModel.setDidOnboardOnce()
        }
    }
}

#Preview {
    OnboardingView()
}
