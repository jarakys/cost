//
//  StorageKeys.swift
//  Cost
//
//  Created by Kirill on 9/29/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import Foundation

enum StorageKey : String {
    case language = "language"
    case weekStartOn = "weekStartOn"
    case currency = "currency"
    case user = "user"
    case currencyList = "currencyList"
    
    func string() -> String {
        return self.rawValue
    }
    
}
