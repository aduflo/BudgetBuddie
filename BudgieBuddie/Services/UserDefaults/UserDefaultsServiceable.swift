//
//  UserDefaultsServiceable.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 2/16/26.
//

import Foundation

protocol UserDefaultsServiceable {
    func set(_ value: Any?, forKey key: UserDefaultsKey)
    func bool(forKey key: UserDefaultsKey) -> Bool
    func double(forKey key: UserDefaultsKey) -> Double
    func integer(forKey key: UserDefaultsKey) -> Int
}
