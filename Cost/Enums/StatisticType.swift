
//
//  StatisticType.swift
//  Cost
//
//  Created by Kirill on 09.10.2019.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import Foundation

enum StatisticType : String {
    case income = "Income"
    case costs = "Costs"
    
    func string() ->String {
        return self.rawValue
    }
    
}
