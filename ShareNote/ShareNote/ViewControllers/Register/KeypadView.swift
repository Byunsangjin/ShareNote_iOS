//
//  KeypadView.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/02.
//

import UIKit

protocol KeypadDelegate {
    func selectKeypad(sender: UIButton)
}

class KeypadView: UIStackView {
    
    let hStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        
        for num in 1...3 {
            let button = UIButton.createNumberButton(number: String(num))
            button.addTarget(self, action: #selector(buttonTouched(sender:)), for: .touchUpInside)
            $0.addArrangedSubview(button)
        }
    }
    
    let hStackView1 = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        
        for num in 4...6 {
            let button = UIButton.createNumberButton(number: String(num))
            button.addTarget(self, action: #selector(buttonTouched(sender:)), for: .touchUpInside)
            $0.addArrangedSubview(button)
        }
    }
    
    let hStackView2 = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        
        for num in 7...9 {
            let button = UIButton.createNumberButton(number: String(num))
            button.addTarget(self, action: #selector(buttonTouched(sender:)), for: .touchUpInside)
            $0.addArrangedSubview(button)
        }
    }
    
    let hStackView3 = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        
        $0.addArrangedSubview(UIView())
        
        let button = UIButton.createNumberButton(number: "0")
        button.addTarget(self, action: #selector(buttonTouched(sender:)), for: .touchUpInside)
        $0.addArrangedSubview(button)
        
        let backButton = UIButton().then {
            $0.setImage(UIImage(named: "iconBacks"), for: .normal)
        }
        backButton.addTarget(self, action: #selector(buttonTouched(sender:)), for: .touchUpInside)
        $0.addArrangedSubview(backButton)
    }
    
    var keypadDelegate: KeypadDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        axis = .vertical
        distribution = .fillEqually
        
        addArrangedSubview(hStackView)
        addArrangedSubview(hStackView1)
        addArrangedSubview(hStackView2)
        addArrangedSubview(hStackView3)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func buttonTouched(sender: UIButton) {
        keypadDelegate?.selectKeypad(sender: sender)
    }
}
