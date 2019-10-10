//
//  EarnModel.swift
//  Cost
//
//  Created by Kirill on 09.10.2019.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import Foundation

class EarnModel : BaseDailyModel {
    var Income: String
    
    enum CodingKeys: String, CodingKey {
        case Income
    }
    
    init(categoryId: String, date: String, description: String, currencyBase: String, currency: String, earn: String) {
        self.Income = earn
        super.init(categoryId: categoryId, date: date, description: description, currencyBase: currencyBase, currency: currency)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        Income = try container.decode(String.self, forKey: .Income)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(Income, forKey: .Income)
        try super.encode(to: encoder)
    }
    
}
