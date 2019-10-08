//
//  SegmentControlView.swift
//  Cost
//
//  Created by Kirill on 9/20/19.
//  Copyright © 2019 com.cost.app. All rights reserved.
//

import UIKit





protocol  SegmentControlDelegate : class {
    func changeToIndex(index: Int)
}





class SegmentControlView: UIView {

    private var buttonTitiles:[String]!
    private var buttons: [UIButton] = []
    private var selectorView: UIView!
    private var _selectedIndex = 0
    var buttonBackgroundColor: UIColor?
    var textColor: UIColor = .black
    var selectorViewColor: UIColor = .red {
        didSet {
            self.selectorView.backgroundColor = self.selectorViewColor
        }
    }
    var selectorTextColor: UIColor = .red
    
    weak var delegate: SegmentControlDelegate?
    
    convenience init(frame: CGRect, buttonTitiles: [String]) {
        self.init(frame: frame)
        self.buttonTitiles = buttonTitiles
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
    }
    
    public var selectedIndex:Int {
        return _selectedIndex
    }
    
    func setButtonTitiles(buttonTitiles: [String]) {
        self.buttonTitiles = buttonTitiles
        updateView()
    }
    
    private func configureStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 1
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
    }
    
    private func configureSelectorVIew() {
        let selectorWidth = frame.width / CGFloat(self.buttonTitiles.count)
        let height:CGFloat = 6
        selectorView = UIView(frame: CGRect(x: 0, y: self.frame.height-height, width: selectorWidth, height: height))
        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
        let selectorPosition = frame.width / CGFloat(buttonTitiles.count) * CGFloat(selectedIndex)
        self.selectorView.frame.origin.x = selectorPosition
    }
    
    private func createButton() {
        buttons = []
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitile in buttonTitiles {
            let button = UIButton(type: .system)
            button.backgroundColor = buttonBackgroundColor == nil ? UIColor.white : buttonBackgroundColor
            button.setTitle(buttonTitile, for: .normal)
            button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            buttons.append(button)
        }
        buttons[selectedIndex].setTitleColor(selectorTextColor, for: .normal)
    }
    
    @objc func buttonAction(sender: UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
                let selectorPosition = frame.width / CGFloat(buttonTitiles.count) * CGFloat(buttonIndex)
                
                guard _selectedIndex != buttonIndex else { return }
                delegate?.changeToIndex(index: buttonIndex)
                _selectedIndex = buttonIndex
                UIView.animate(withDuration: 0.3) {
                    self.selectorView.frame.origin.x = selectorPosition
                }
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
    }
    
    
    func setIndex(index: Int) {
        buttons.forEach({$0.setTitleColor(textColor, for: .normal)})
        let button = buttons[index]
        
        _selectedIndex = index
        button.setTitleColor(selectorTextColor, for: .normal)
        let selectorPosition = frame.width / CGFloat(buttonTitiles.count) * CGFloat(_selectedIndex)
        self.selectorView.frame.origin.x = selectorPosition
        buttons[index].setTitleColor(selectorTextColor, for: .normal)
    }
    
    private func updateView() {
        self.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        createButton()
        configureStackView()
        configureSelectorVIew()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
