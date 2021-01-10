//
//  PasswordKeypadView.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/10.
//

import SwiftyBeaver
import UIKit

class PasswordKeypadView: UIView {
    
    var keypadStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 1.0
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    var numberArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        
        numberArray.shuffle()
        
        addSubview(keypadStackView)
        
        for _ in 0..<3 {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.spacing = 1.0
            stackView.alignment = .fill
            stackView.distribution = .fillEqually
            
            for _ in 0..<3 {
                let button = UIButton()
                button.setTitle(numberArray.popLast()!, for: .normal)
                button.addTarget(self, action: #selector(numberBtnTouched), for: .touchUpInside)
                stackView.addArrangedSubview(button)
            }
            
            keypadStackView.addArrangedSubview(stackView)
        }
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 1.0
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        let clearButton = UIButton()
        clearButton.setTitle("Clear", for: .normal)
        clearButton.addTarget(self, action: #selector(clearBtnTouched), for: .touchUpInside)
        stackView.addArrangedSubview(clearButton)
        
        let button = UIButton()
        button.setTitle(numberArray.popLast()!, for: .normal)
        button.addTarget(self, action: #selector(numberBtnTouched), for: .touchUpInside)
        stackView.addArrangedSubview(button)
        
        let backwardButton = UIButton()
        backwardButton.setTitle("Backward", for: .normal)
        backwardButton.addTarget(self, action: #selector(backwardBtnTouched), for: .touchUpInside)
        stackView.addArrangedSubview(backwardButton)
        
        keypadStackView.addArrangedSubview(stackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func clearBtnTouched() {
        
    }

    @objc
    func backwardBtnTouched() {
        
    }
    
    @objc
    func numberBtnTouched(sender: UIButton) {
        SwiftyBeaver.verbose("\(sender.titleLabel?.text)")
    }
    
    override func updateConstraints() {
        keypadStackView.snp.makeConstraints { make in
            make.width.height.equalTo(self)
        }
        
        super.updateConstraints()
    }
}
