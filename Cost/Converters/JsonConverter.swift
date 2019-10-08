//
//  JsonConverter.swift
//
//  Created by Chernov Kirill on 9/11/19.
//

import Foundation
struct JsonConverter {
    
    static func toString(value: Any) throws -> String {
        let data = try JSONSerialization.data(withJSONObject: value, options: JSONSerialization.WritingOptions.prettyPrinted)
        let json = String.init(data: data, encoding: String.Encoding.utf8)!
        return json
    }
    
    static func jsonToObject<T : Codable>(stringJson: String) ->T {
        let data = stringJson.data(using: .utf8)!
        debugPrint(data)
        let object: T = try! JSONDecoder().decode(T.self, from: data)
        return object
    }
    
    static func dataToObject<T : Codable>(data: Data) ->T {
        let object: T = try! JSONDecoder().decode(T.self, from: data)
        return object
    }
    
}
