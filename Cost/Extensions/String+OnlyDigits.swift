//
//  String+OnlyDigits.swift
//  Cost
//
//  Created by Kirill on 09.10.2019.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import Foundation
extension String {
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
}
