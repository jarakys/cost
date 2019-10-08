//
//  Networking.swift
//  Cost
//
//  Created by Kirill on 9/23/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import Foundation
import Alamofire
protocol Networking {
    
    func getCategory(action: @escaping (_ data:DataResponse<Any, AFError>)->Void)
    
    func getCurrency(action: @escaping (_ data: DataResponse<Any, AFError>)->Void) 
    
    func register(user: UserRegistrationModel, complition: @escaping (_ response: DataResponse<Any,AFError>)->Void)
    
    func logIn(user: UserLoginModel, complition: @escaping (_ response: DataResponse<Any,AFError>)->Void)
    
    func getDailyReport(currecncyBase: String, currency: String, complition: @escaping (_ data: DataResponse<Any, AFError>)->Void)
    
    
}
