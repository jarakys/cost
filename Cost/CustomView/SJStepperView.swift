//
//  SJStepperView.swift
//  Cost
//
//  Created by Kirill on 9/20/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

protocol SJStepperViewDelegate : AnyObject {
    func downButtonTapped(value: String)
    func upButtonTapped(value: String)
}

import UIKit

class SJStepperView: UIView {
    var stepperColor: UIColor =  .lightGray {
        didSet {
            titleLabel?.textColor = self.stepperColor
            upButton?.tintColor = self.stepperColor
            downButton?.tintColor = self.stepperColor
        }
    }
    
    weak var delegate: SJStepperViewDelegate?
    
    var title: String?
    var upButtonImage: UIImage?
    var downButtonImage: UIImage?
    var iterableThrought: Calendar.Component = .day {
        didSet {
            setTitle(text: "String")
        }
    }
    private var titleLabel: UILabel?
    private var upButton: UIButton? = UIButton(type: .custom)
    private var downButton: UIButton? = UIButton(type: .custom)
    convenience init(frame: CGRect, title: String, stepperColor: UIColor) {
        self.init(frame: frame)
        self.title = title
        self.stepperColor = stepperColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateView()
    }
    
    
    private func createButton() {
        
        upButtonImage = upButtonImage?.withRenderingMode(.alwaysTemplate)
        downButtonImage = downButtonImage?.withRenderingMode(.alwaysTemplate)
        upButton?.contentHorizontalAlignment = .left
        upButton?.addTarget(self, action: #selector(upButtomTapped), for: .touchUpInside)
        downButton?.addTarget(self, action: #selector(downButtomTapped), for: .touchUpInside)
        downButton?.contentHorizontalAlignment = .left
        upButton?.contentVerticalAlignment = .bottom
        downButton?.contentVerticalAlignment = .top
        upButton?.setImage(upButtonImage, for: .normal)
        downButton?.setImage(downButtonImage, for: .normal)
        
        
    }
    
    private func createTitle() {
        titleLabel = UILabel()
        titleLabel?.textColor = stepperColor
        titleLabel?.text = title
        titleLabel?.textAlignment = .right
        titleLabel?.font = UIFont(name: "SegueUI-SemiBold.ttf", size: 20)
    }
    
    
    private func configureStackViews() {
        
        let verticalStack = UIStackView(arrangedSubviews: [upButton!,downButton!])
        verticalStack.axis = .vertical
        verticalStack.alignment = .center
        verticalStack.distribution = .fillEqually
        
        let stack = UIStackView(arrangedSubviews: [titleLabel!,verticalStack])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 10
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
    }
    
    private func updateView() {
        createButton()
        createTitle()
        configureStackViews()
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
    }
    
    func setTitle(text: String) {
        //updateView()
        title = text
        titleLabel?.text = title
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

//Action
extension SJStepperView {
    
    @objc func upButtomTapped() {
        delegate?.upButtonTapped(value: "down")
    }
    
    @objc func downButtomTapped() {
        delegate?.downButtonTapped(value: "down")
    }
    
    
}
