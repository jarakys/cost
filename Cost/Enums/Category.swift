//
//  Category.swift
//  Cost
//
//  Created by Kirill Chernov on 9/19/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import UIKit
enum Category : Int {
    
    case Balance
    case Earn
    case Costs
    
    func string() -> String {
        return  String(describing: self).lowercased().localizedString()
    }
    
    func index() -> Int {
        return self.rawValue
    }
    
    func color() -> UIColor {
        var color = UIColor.black
        switch self {
        case .Balance:
            color = UIColor(red:0.06, green:0.80, blue:0.51, alpha:1.0)
        case .Earn:
            color = UIColor(red:0.20, green:0.59, blue:0.99, alpha:1.0)
        case .Costs:
            color = UIColor(red:1.00, green:0.30, blue:0.18, alpha:1.0)
        }
        return color
    }
    
    func cardImage() -> UIImage {
        var image:UIImage
        switch self {
        case .Balance:
            image = UIImage(named: "balanceCard")!
        case .Earn:
            image = UIImage(named: "earnedCard")!
        case .Costs:
            image = UIImage(named: "costsCard")!
        }
        return image
    }
    
    func arrowImage() -> UIImage {
        var image:UIImage
        switch self {
        case .Balance:
            image = UIImage()
        case .Earn:
            image = UIImage(named: "earnArrow")!
        case .Costs:
            image = UIImage(named: "costsArrow")!
        }
        return image
    }
    
}
