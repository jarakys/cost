//
//  SelectableTableViewCell.swift
//  Cost
//
//  Created by Kirill on 9/29/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import UIKit

class SelectableTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if let image = self.viewWithTag(2) as? UIImageView {
            image.isHidden = self.isSelected ? false : true
        }
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = .clear
        self.selectedBackgroundView = bgColorView
        // Configure the view for the selected state
    }

}
