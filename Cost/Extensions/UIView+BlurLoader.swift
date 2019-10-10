//
//  UIView+BlurLoader.swift
//  Cost
//
//  Created by Kirill on 10/2/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import UIKit

extension UIView {
    func showBlurLoader() {
        let blurLoader = BlurLoader(frame: frame)
        self.addSubview(blurLoader)
        self.isUserInteractionEnabled = true
        blurLoader.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        blurLoader.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        blurLoader.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        blurLoader.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        blurLoader.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func removeBluerLoader() {
        if let blurLoader = subviews.first(where: { $0 is BlurLoader }) {
            self.isUserInteractionEnabled = false
            blurLoader.removeFromSuperview()
        }
    }
}

