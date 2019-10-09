//
//  Bundle+SetLanguage.swift
//  Cost
//
//  Created by Kirill on 09.10.2019.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import Foundation
extension Bundle {
    private static var bundle: Bundle!

    public static func localizedBundle() -> Bundle! {
        if bundle == nil {
            let storage = StorageManager()
            let indexLanguage = storage.getData(key: .language)
            var lang: String = "en"
            if  indexLanguage == "1" {
                lang = "ar"
            }
            let path = Bundle.main.path(forResource: lang, ofType: "lproj")
            bundle = Bundle(path: path!)
        }

        return bundle;
    }

    public static func setLanguage(lang: String) {
        
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        bundle = Bundle(path: path!)
    }
}
