//
//  UserDefaults+Extensions.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 1/16/26.
//

import Foundation

extension UserDefaults {
    enum Key {
        enum App: UserDefaultsKey {
            static let didOnboardOnce = compose(key: "didOnboardOnce")
        }
        enum Settings: UserDefaultsKey {
            static let monthlyAllowance = compose(key: "monthlyAllowance")
            static let warningThreshold = compose(key: "warningThreshold")
        }
        enum SpendRepository: UserDefaultsKey {
            static let didSetupOnce = compose(key: "didSetupOnce")
        }
    }
}

fileprivate protocol UserDefaultsKey {
    static func compose(key: String) -> String
}

extension UserDefaultsKey {
    static func compose(key: String) -> String {
        "\(String(describing: Self.self)).\(key)"
    }
}
