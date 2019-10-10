//
//  Statistic.swift
//  Cost
//
//  Created by Kirill Chernov on 9/19/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import Foundation
struct StatisticItem : Codable, Hashable {
    let id: Int
    let income: Float
    let costs: Float
    let categoryName: Int
    let logoFilePath: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
