//
//  UserModel.swift
//  Cost
//
//  Created by Kirill on 10/1/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import Foundation

struct UserModel : Codable {
    let email: String
    let id: Int
    let name: String
    let token: Int
}
