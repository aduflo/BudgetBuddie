//
//  CircleButton.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 2/12/26.
//

import SwiftUI

struct CircleButton: View {
    // Instance vars
    private let systemImage: String
    typealias Action = () -> ()
    private let action: Action
    
    // Constructors
    init(
        systemImage: String,
        action: @escaping Action
    ) {
        self.systemImage = systemImage
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Color.backgroundPrimary
                    .frame(
                        width: 40.0,
                        height: 40.0
                    )
                    .clipShape(
                        Circle()
                    )
                
                Image(systemName: systemImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 16.0)
                    .foregroundStyle(.foregroundPrimary)
            }
        }
    }
}

#Preview {
    CircleButton(
        systemImage: SystemImage.arrowClockwise,
        action: {}
    )
}
