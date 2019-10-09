//
//  UserCategories.swift
//  Cost
//
//  Created by Kirill on 9/29/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import UIKit

enum UserCategories : String, CaseIterable {
    case general = "General"
    case groceries = "Groceries"
    case food = "Food"
    case drinks = "Drinks"
    case shopping = "Shopping"
    case personal = "Personal"
    case entertain = "Entertain"
    case movies = "Movies"
    case social = "Social"
    case transport = "Transport"
    case appStore = "App Store"
    case mobile = "Mobile"
    case computer = "Computer"
    case gifts = "Gifts"
    case housing = "Housing"
    
    func string() ->String {
        return self.rawValue.localizedString()
    }
    
    private func imageName() -> String {
         return self.rawValue
    }
    
    func image() -> String {
        return self.imageName().replacingOccurrences(of: " ", with: "").lowercased()
    }
    
    
}
