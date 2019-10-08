//
//  UserRegistrationModel.swift
//  Cost
//
//  Created by Kirill on 10/1/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import Foundation

class UserRegistrationModel : UserLoginModel {
    
    let Name: String
    
    init(email: String, password: String, name: String, accountType: Int) {
        Name = name
        print(Name)
        super.init(email: email, password: password, accountType: accountType)
    }
    
    enum CodingKeys: String, CodingKey {
        case Name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        Name = try container.decode(String.self, forKey: .Name)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(Name, forKey: .Name)
        try super.encode(to: encoder)
    }
    
    
    
}
