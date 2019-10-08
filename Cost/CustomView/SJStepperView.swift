//
//  SJStepperView.swift
//  Cost
//
//  Created by Kirill on 9/20/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

protocol SJStepperViewDelegate : AnyObject {
    func downButtonTapped(value: Int)
    func upButtonTapped(value: Int)
}

import UIKit

@IBDesignable class SJStepperView: UIView {
    @IBInspectable
    var stepperColor: UIColor =  .lightGray {
        didSet {
            titleLabel?.textColor = self.stepperColor
            upButton?.tintColor = self.stepperColor
            downButton?.tintColor = self.stepperColor
        }
    }
    
    weak var delegate: SJStepperViewDelegate?
    
    var title: String?
    @IBInspectable
    var upButtonImage: UIImage? {
        didSet {
            if self.upButtonImage != nil {
                self.upButtonImage = upButtonImage!.withRenderingMode(.alwaysTemplate)
                self.upButton?.setImage(self.upButtonImage, for: .normal)
            }
        }
    }
    @IBInspectable
    var downButtonImage: UIImage? {
        didSet {
            if self.downButtonImage != nil {
                self.downButtonImage = downButtonImage!.withRenderingMode(.alwaysTemplate)
                self.downButton?.setImage(self.downButtonImage, for: .normal)
            }
        }
    }
    
    var value:Int = 0
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
        //updateView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateView()
    }
    
    func setup(title: String, stepperColor: UIColor) {
        self.title = title
        self.stepperColor = stepperColor
        updateView()
    }
    
    
    private func createButton() {
        print(upButtonImage)
        upButtonImage = upButtonImage?.withRenderingMode(.alwaysTemplate)
        downButtonImage = downButtonImage?.withRenderingMode(.alwaysTemplate)
        upButton!.contentHorizontalAlignment = .left
        
        upButton?.addTarget(self, action: #selector(upButtomTapped), for: .touchUpInside)
        downButton?.addTarget(self, action: #selector(downButtomTapped), for: .touchUpInside)
        downButton?.contentHorizontalAlignment = .left
        upButton?.contentVerticalAlignment = .bottom
        downButton?.contentVerticalAlignment = .top
        upButton?.setImage(upButtonImage, for: .normal)
        downButton?.setImage(downButtonImage, for: .normal)
        upButton?.tintColor = self.stepperColor
        downButton?.tintColor = self.stepperColor
        
        
    }
    
    private func createTitle() {
        titleLabel = UILabel()
        titleLabel?.textColor = stepperColor
        titleLabel?.text = title
        titleLabel?.textAlignment = .right
        titleLabel?.font = UIFont(name: "SegueUI-SemiBold.ttf", size: 20)
        titleLabel?.textColor = self.stepperColor
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
    }
    
    func setTitle(text: String) {
        title = text
        titleLabel?.text = title
    }

}

//Action
extension SJStepperView {

    @objc func upButtomTapped() {
        value += 1
        delegate?.upButtonTapped(value: value)
    }
    
    @objc func downButtomTapped() {
        value -= 1
        delegate?.downButtonTapped(value: value)
    }
    
    
}
