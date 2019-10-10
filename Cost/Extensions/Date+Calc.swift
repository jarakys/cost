//
//  Date+Calc.swift
//  Cost
//
//  Created by Kirill on 08.10.2019.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import Foundation

extension Date {
    
    func getDescription() ->String {
        let dateFormmater = DateFormatter()
        dateFormmater.locale = Locale(identifier: "en_US_POSIX")
        dateFormmater.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormmater.dateFormat = "dd.MM"
        return dateFormmater.string(from: self)
    }
    
    func getDescription(formattingStyle: String) ->String {
        let dateFormmater = DateFormatter()
        dateFormmater.locale = Locale(identifier: "en_US_POSIX")
        dateFormmater.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormmater.dateFormat = formattingStyle
        return dateFormmater.string(from: self)
    }
    
    func getDateByOffset(offset: Int) -> Date {
         var component = DateComponents()
         component.day = offset
         let date = Calendar.current.date(byAdding: component, to: self)!
         return date
    }
    
    func getDayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        // uncomment to enforce the US locale
        // dateFormatter.locale = Locale(identifier: "en-US")
        dateFormatter.setLocalizedDateFormatFromTemplate("EEE")
        return dateFormatter.string(from: self)
    }
    
    func startAndEndOfWeek(dayOfWeek: DaysOfWeek) -> (start:Date,end:Date) {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = dayOfWeek.index()
        let start = calendar.date(from: Calendar.gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
        let sunday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
        let end =  calendar.date(byAdding: .day, value: 6, to: sunday)!
        return(start,end)
    }
    
    func endOfWeek(offset: Int, dayOfWeek: DaysOfWeek) -> Date? {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = dayOfWeek.index()
        return calendar.date(from: Calendar.gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
    }
    
    func addDaysToDate(weekOffset: Int) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        let date = calendar.date(byAdding: .day, value: 7*weekOffset-1, to: self)!
        return date
    }
    
//    func getNearestPreviousDayOfWeekDate(day: DaysOfWeek) -> Date {
//
//    }
    
    
    
}

extension Calendar {
    static let gregorian = Calendar(identifier: .gregorian)
}
extension Date {

}
