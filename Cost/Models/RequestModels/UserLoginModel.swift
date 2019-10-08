//
//  UserLoginModel.swift
//  Cost
//
//  Created by Kirill on 10/1/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import Foundation

class UserLoginModel : Codable {
    let Email: String
    let Password: String
    let accountType: Int
    
    init(email: String, password: String, accountType: Int) {
        Email = email
        Password = password
        self.accountType = accountType
    }
    
    private enum CodingKeys: String, CodingKey {
        case Email
        case Password
        case accountType
    }

    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(Email, forKey: .Email)
        try container.encode(Password, forKey: .Password)
        try container.encode(accountType, forKey: .accountType)
    }
    
}
