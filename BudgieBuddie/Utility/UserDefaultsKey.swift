//
//  UserDefaultsKey.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/16/26.
//

import Foundation

enum UserDefaultsKey {
    enum App {
        static let didOnboardOnce = compose(key: "didOnboardOnce")
    }
    enum Settings {
        static let monthlyAllowance = compose(key: "monthlyAllowance")
        static let warningThreshold = compose(key: "warningThreshold")
        static let defaultSpendTrendViewpoint = compose(key: "defaultSpendTrendViewpoint")
    }
    enum SpendRepository {
        static let didSetupOnce = compose(key: "didSetupOnce")
    }
}

fileprivate extension UserDefaultsKey {
    static func compose(key: String) -> String {
        "\(String(describing: Self.self)).\(key)"
    }
}
