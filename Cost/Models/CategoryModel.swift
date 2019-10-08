//
//  CategoryModel.swift
//  Cost
//
//  Created by Kirill on 9/23/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import Foundation

struct CategoryModel : Decodable {
    let id: Int
    let logoFilePath: String
    let name: String
}
