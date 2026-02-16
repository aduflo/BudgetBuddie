//
//  UserDefaultsService.swift
//  BudgieBuddie
//
//  Created by Adam Duflo on 2/16/26.
//

import Foundation

struct UserDefaultsService: UserDefaultsServiceable {
    func set(_ value: Any?, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func bool(forKey key: String) -> Bool {
        UserDefaults.standard.bool(forKey: key)
    }
    
    func double(forKey key: String) -> Double {
        UserDefaults.standard.double(forKey: key)
    }
    
    func integer(forKey key: String) -> Int {
        UserDefaults.standard.integer(forKey: key)
    }
}
