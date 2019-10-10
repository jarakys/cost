//
//  Statistic.swift
//  Cost
//
//  Created by Kirill on 09.10.2019.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import Foundation

struct Statistic : Codable {
    var totalCost: Float
    var dailyReportItem: [StatisticItem]
}
