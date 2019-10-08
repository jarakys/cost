//
//  CategoryCollectionViewCell.swift
//  Cost
//
//  Created by Kirill on 9/23/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    override var isSelected: Bool {
        didSet {
            // set color according to state
            self.backgroundColor = self.isSelected ? .white : .clear
            if let image  = self.viewWithTag(1) as? UIImageView {
                image.tintColor = self.isSelected ? .red : .gray
            }
        }
    }
}
