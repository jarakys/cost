//
//  DaysOfWeek.swift
//  Cost
//
//  Created by Kirill on 08.10.2019.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import Foundation

enum DaysOfWeek : Int {
    case saturday = 1
    case sunday = 2
    case monday = 3
    case tuesday = 4
    case wednesday = 5
    case thursday = 6
    case friday = 7
    
    
    
    func index() -> Int {
        return self.rawValue
    }
    
    func string() -> String {
        
    }
    
}
