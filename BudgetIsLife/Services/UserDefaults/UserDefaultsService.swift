//
//  UserDefaultsService.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 2/16/26.
//

import Foundation

struct UserDefaultsService: UserDefaultsServiceable {
    func set(_ value: Any?, forKey key: UserDefaultsKey) {
        UserDefaults.standard.set(value, forKey: key.value)
    }
    
    func bool(forKey key: UserDefaultsKey) -> Bool {
        UserDefaults.standard.bool(forKey: key.value)
    }
    
    func double(forKey key: UserDefaultsKey) -> Double {
        UserDefaults.standard.double(forKey: key.value)
    }
    
    func integer(forKey key: UserDefaultsKey) -> Int {
        UserDefaults.standard.integer(forKey: key.value)
    }
}
