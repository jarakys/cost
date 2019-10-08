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
    }
    
    func removeBluerLoader() {
        if let blurLoader = subviews.first(where: { $0 is BlurLoader }) {
            blurLoader.removeFromSuperview()
        }
    }
}

