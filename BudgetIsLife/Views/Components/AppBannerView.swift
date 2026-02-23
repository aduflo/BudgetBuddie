//
//  AppBannerView.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 2/7/26.
//

import SwiftUI

struct AppBannerView: View {
    var body: some View {
        Text(Copy.appName)
            .font(.largeTitle)
            .fontWeight(.heavy)
            .foregroundStyle(.appPrimary)
    }
}

#Preview {
    AppBannerView()
}
