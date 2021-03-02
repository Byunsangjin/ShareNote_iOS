//
//  RegistSimplePasswordViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/02.
//

import UIKit

class RegistSimplePasswordViewController: UIViewController {

    let closeButton = UIButton().then {
        $0.setImage(UIImage(named: "icClose"), for: .normal)
    }
    
    let titleLabel = UILabel().then {
        $0.text = "간편비밀번호 설정"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 17)
        $0.textAlignment = .center
    }
    
    let descriptionLabel = UILabel().then {
        $0.text = "Sharenote 비밀번호를 설정합니다."
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 17, style: .Regular)
        $0.textAlignment = .center
    }
    
    let passwordIconStackView = UIStackView()
    
    let messageLabel = UILabel().then {
        $0.text = "확인을 위해 한번 더 입력해 주세요"
        $0.textColor = .grey3
        $0.font = UIFont.spoqaHanSans(size: 13, style: .Regular)
        $0.textAlignment = .center
    }
    
    let keypad = KeypadView()
    
    // MARK: Methods
    override func viewDidLoad() {
        setUI()
        
        keypad.keypadDelegate = self
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(passwordIconStackView)
        view.addSubview(messageLabel)
        
        view.addSubview(keypad)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(47)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.width.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(121)
            make.left.right.equalTo(view)
            make.height.equalTo(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.left.right.equalTo(view)
            make.height.equalTo(20)
        }
        
        passwordIconStackView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            make.centerX.equalTo(view)
            make.width.equalTo(160)
            make.height.equalTo(15)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordIconStackView.snp.bottom).offset(15)
            make.left.right.equalTo(view)
            make.height.equalTo(16)
        }
        
        keypad.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(240)
        }
        
        super.updateViewConstraints()
    }
}

extension RegistSimplePasswordViewController: KeypadDelegate {
    func selectKeypad(sender: UIButton) {
        print(sender.titleLabel?.text)
    }
}
