//
//  UserDefaultsKey.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 1/16/26.
//

import Foundation

enum UserDefaultsKey: String {
    case didOnboardOnce
    case monthlyAllowance
    case warningThreshold
    case defaultSpendTrendViewpoint
    case didSetupOnce
    
    var value: String {
        switch self {
        case .didOnboardOnce: compose(nameSpace: .app)
        case .monthlyAllowance: compose(nameSpace: .settings)
        case .warningThreshold: compose(nameSpace: .settings)
        case .defaultSpendTrendViewpoint: compose(nameSpace: .settings)
        case .didSetupOnce: compose(nameSpace: .spendRepository)
        }
    }
}

fileprivate extension UserDefaultsKey {
    enum NameSpace: String {
        case app
        case settings
        case spendRepository
    }
    
    func compose(nameSpace: NameSpace) -> String {
        "\(nameSpace.rawValue).\(rawValue)"
    }
}
