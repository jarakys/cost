//
//  ActivityIndicator.swift
//  Cost
//
//  Created by Kirill on 10/2/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import UIKit

class ActivityIndicator: UIActivityIndicatorView {
    
    func displayActivityIndicatorView() -> () {
        UIApplication.shared.beginIgnoringInteractionEvents()
        self.superview!.bringSubviewToFront(self)
        self.isHidden = false
        self.backgroundColor = .green
        self.startAnimating()
    }
    
    func hideActivityIndicatorView() -> () {
        if !self.isHidden{
            DispatchQueue.main.async {
                UIApplication.shared.endIgnoringInteractionEvents()
                self.stopAnimating()
                self.isHidden = true
                
            }
        }
        
    }

}
