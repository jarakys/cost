//
//  BaseDailyModel.swift
//  Cost
//
//  Created by Kirill on 09.10.2019.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import Foundation

class BaseDailyModel : Codable {
    var CategoryId: String
    var date: String
    var Description: String
    var CurrencyBase: String
    var Currency: String
    
    private enum CodingKeys: String, CodingKey {
        case CategoryId
        case date
        case Description
        case CurrencyBase
        case Currency
    }
    
    init(categoryId: String, date: String, description: String, currencyBase: String, currency: String) {
        self.CategoryId = categoryId
        self.date = date
        self.Description = description
        self.CurrencyBase = currencyBase
        self.Currency = currency
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(CategoryId, forKey: .CategoryId)
        try container.encode(date, forKey: .date)
        try container.encode(Description, forKey: .Description)
        try container.encode(CurrencyBase, forKey: .CurrencyBase)
        try container.encode(Currency, forKey: .Currency)
    }
    
}
