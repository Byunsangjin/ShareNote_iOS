//
//  SimplePasswordViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/10.
//

import Then
import UIKit

class SimplePasswordViewController: UIViewController {
    
    // MARK: Constants
    let titleLabel = UILabel().then {
        $0.text = "Sharenote 암호를 설정합니다."
        $0.textColor = .black
    }
    
    let pwdKeypadView = PasswordKeypadView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let passwordStackView = UIStackView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 1
    }
    
    let descriptionLabel = UILabel().then {
        $0.text = "확인을 위해 한번 더 입력해 주세요"
        $0.textColor = .black
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pwdKeypadView.delegate = self
        
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        
        view.addSubview(passwordStackView)
        for _ in 0..<6 {
            let passwordDot = UIView()
            passwordDot.backgroundColor = .red
            passwordStackView.addArrangedSubview(passwordDot)
        }
        
        view.addSubview(descriptionLabel)
        view.addSubview(pwdKeypadView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.snp.top).offset(200)
        }
        
        passwordStackView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(titleLabel.snp.bottom).offset(45)
            make.width.equalTo(140)
            make.height.equalTo(25)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordStackView.snp.bottom).offset(25)
            make.centerX.equalTo(view)
        }
        
        pwdKeypadView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.width.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.4)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        super.updateViewConstraints()
    }
}

extension SimplePasswordViewController: PasswordProtocol {
    func backwardAction() {
        logger.verbose(#function)
    }
    
    func clearAction() {
        logger.verbose(#function)
    }
    
    func numberAction(sender: UIButton) {
        logger.verbose(sender.titleLabel?.text)
    }
}
