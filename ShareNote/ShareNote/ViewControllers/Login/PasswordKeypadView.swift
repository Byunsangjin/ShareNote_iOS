//
//  PasswordKeypadView.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/10.
//

import UIKit

protocol PasswordProtocol {
    func backwardAction()
    func numberAction(sender: UIButton)
}

class PasswordKeypadView: UIView {
        
    var keypadStackView = UIStackView().makeStackView(axis: .vertical).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    var numberArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    var delegate: PasswordProtocol?
    
    // MARK: Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        numberArray.shuffle()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        addSubview(keypadStackView)
        
        for _ in 0..<3 {
            let stackView = UIStackView().makeStackView()
            
            for _ in 0..<3 {
                let numberButton = UIButton().makeButton(target: self, title: numberArray.popLast()!, selector: #selector(numberBtnTouched))
                stackView.addArrangedSubview(numberButton)
            }
            
            keypadStackView.addArrangedSubview(stackView)
        }
        
        let stackView = UIStackView().makeStackView()
        
        let clearButton = UIButton()
        
        stackView.addArrangedSubview(clearButton)
        
        let numberButton = UIButton().makeButton(target: self, title: numberArray.popLast()!, selector: #selector(numberBtnTouched))
        stackView.addArrangedSubview(numberButton)
        
        let backwardButton = UIButton().makeButton(target: self, title: "", selector: #selector(backwardBtnTouched))
        backwardButton.setImage(UIImage(named: "iconBacks"), for: .normal)
        stackView.addArrangedSubview(backwardButton)
        
        keypadStackView.addArrangedSubview(stackView)
    }

    @objc
    func backwardBtnTouched() {
        delegate?.backwardAction()
    }
    
    @objc
    func numberBtnTouched(sender: UIButton) {
        delegate?.numberAction(sender: sender)
    }
    
    override func updateConstraints() {
        keypadStackView.snp.makeConstraints { make in
            make.width.height.equalTo(self)
        }
        
        super.updateConstraints()
    }
}

extension UIStackView {
    func makeStackView(axis: NSLayoutConstraint.Axis = .horizontal) -> UIStackView {
        self.axis = axis
        self.spacing = 0.5
        self.alignment = .fill
        self.distribution = .fillEqually
        
        return self
    }
}

extension UIButton {
    func makeButton(target: Any?, title: String, selector: Selector) -> UIButton {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.addTarget(target, action: selector, for: .touchUpInside)
        
        return self
    }
}
