//
//  CostsModel.swift
//  Cost
//
//  Created by Kirill on 09.10.2019.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import Foundation

class CostsModel: BaseDailyModel {
    var Costs: String
    
    enum CodingKeys: String, CodingKey {
        case Costs
    }
    
    init(categoryId: String, date: String, description: String, currencyBase: String, currency: String, costs: String) {
        self.Costs = costs
        super.init(categoryId: categoryId, date: date, description: description, currencyBase: currencyBase, currency: currency)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        Costs = try container.decode(String.self, forKey: .Costs)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(Costs, forKey: .Costs)
        try super.encode(to: encoder)
    }
    
}
