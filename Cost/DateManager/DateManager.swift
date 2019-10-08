//
//  DateManager.swift
//  Cost
//
//  Created by Kirill on 08.10.2019.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import Foundation

struct DateManager {
    
//    static func getNearestPreviousDayOfWeekDate(day: DaysOfWeek) -> Date {
//        
//    }
//    
//    static func getNearestNextDayOfWeekDate(day: DaysOfWeek) -> Date {
//        
//    }
    
    static func getDateByOffset(offset: Int) -> Date {
        var component = DateComponents()
        component.day = offset
        let date = Calendar.current.date(byAdding: component, to: Date())!
        return date
    }
    
    static func getCurrentDate() -> Date {
        return Date()
    }
}
