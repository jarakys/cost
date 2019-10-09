//
//  RequestManager.swift
//  Cost
//
//  Created by Kirill on 9/23/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import Foundation
import Alamofire
struct RequestManager : Networking {

    
    static let URL:String = "http://starov88-001-site10.itempurl.com/api/"
    
    func register(user: UserRegistrationModel, complition: @escaping (_ response: DataResponse<Any,AFError>)->Void) {
        AF.request(RequestManager.URL + "account/registration",
                   method: .post,
             
                   parameters: user,
                   encoder: JSONParameterEncoder.default).responseJSON { response in
                    complition(response)
        }
    }
    
    func logIn(user: UserLoginModel, complition: @escaping (_ response: DataResponse<Any,AFError>)->Void) {
        AF.request(RequestManager.URL + "account/authenticate",
                   method: .post,
                   
                   parameters: user,
                   encoder: JSONParameterEncoder.default).responseJSON { response in
                    complition(response)
        }
    }
    
    func getCategory(action: @escaping (_ data:DataResponse<Any, AFError>)->Void) {
        AF.request(RequestManager.URL + "Category").responseJSON { response in
            action(response)
        }
    }
    
    func getCurrency(action: @escaping (_ data: DataResponse<Any, AFError>)->Void) {
        AF.request(RequestManager.URL + "Currency").responseJSON { response in
            action(response)
        }
    }
    
    func getDailyReport(currecncyBase: String, currency: String, complition: @escaping (_ data: DataResponse<Any, AFError>)->Void) {
    }
    
    
}
