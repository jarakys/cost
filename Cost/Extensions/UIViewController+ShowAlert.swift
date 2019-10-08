//
//  UIViewController+ShowAlert.swift
//  Cost
//
//  Created by Kirill on 10/2/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
