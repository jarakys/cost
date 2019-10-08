//
//  Utils.swift
//  Cost
//
//  Created by Kirill on 10/2/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import Foundation

struct Utils {
    static func getStringFromDictionary(dictionary: Dictionary<String,[Any]>) -> String{
        
        let cookieHeader = (dictionary.flatMap({ (key, value) -> String in
            return "\(key) \(value[0])"
        }) as Array).joined(separator: " \n")
        return cookieHeader
    }
}
