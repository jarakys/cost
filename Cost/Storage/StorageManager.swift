//
//  StorageManager.swift
//  Cost
//
//  Created by Kirill on 9/29/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import Foundation
struct StorageManager {
    private let userDefault  = UserDefaults.standard
    
    init() {
        userDefault.register(defaults: [StorageKey.weekStartOn.string():"1"])
        userDefault.register(defaults: [StorageKey.language.string():"0"])
        userDefault.register(defaults: [StorageKey.currency.string():"0"])
    }
    
    func saveData(data: String, key: StorageKey) {
        userDefault.setValue(data, forKey: key.string())
    }
    
    func getData(key: StorageKey) -> String? {
        return userDefault.string(forKey: key.string())
    }
    
}
