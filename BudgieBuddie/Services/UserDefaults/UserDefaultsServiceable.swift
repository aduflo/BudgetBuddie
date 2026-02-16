//
//  UserDefaultsServiceable.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 2/16/26.
//

import Foundation

protocol UserDefaultsServiceable {
    func set(_ value: Any?, forKey key: String)
    func bool(forKey key: String) -> Bool
    func double(forKey key: String) -> Double
    func integer(forKey key: String) -> Int
}
