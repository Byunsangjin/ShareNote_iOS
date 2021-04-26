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
    let closeButton = UIButton().then {
        $0.setImage(UIImage(named: "icClose"), for: .normal)
    }
    
    let titleLabel = UILabel().then {
        $0.text = "간편비밀번호 설정"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 17)
    }
    
    let subTitleLabel = UILabel().then {
        $0.text = "Sharenote 비밀번호를 설정합니다."
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 17, style: .Regular)
    }
    
    let pwdKeypadView = PasswordKeypadView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let passwordStackView = UIStackView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }
    
    let descriptionLabel = UILabel().then {
        $0.text = "확인을 위해 한번 더 입력해 주세요"
        $0.textColor = .grey3
        $0.font = UIFont.spoqaHanSans(size: 13, style: .Regular)
        $0.isHidden = true
    }
    
    // MARK: Variables
    var simplePassword: String = ""
    
    var inputPassword: String = ""
    
    var isInputingRepeatPassword = false
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pwdKeypadView.delegate = self
        
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        
        view.addSubview(passwordStackView)
        for _ in 0..<6 {
            let passwordDot = UIButton()
            passwordDot.setImage(UIImage(named: "imgEmpty"), for: .normal)
            passwordDot.setImage(UIImage(named: "imgFull"), for: .selected)
            passwordStackView.addArrangedSubview(passwordDot)
        }
        
        view.addSubview(descriptionLabel)
        view.addSubview(pwdKeypadView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(39)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.width.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(closeButton.snp.bottom).offset(121)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.centerX.equalTo(titleLabel)
        }
        
        passwordStackView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(subTitleLabel.snp.bottom).offset(17)
            make.width.equalTo(174)
            make.height.equalTo(29)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordStackView.snp.bottom).offset(8)
            make.centerX.equalTo(view)
        }
        
        pwdKeypadView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.width.equalTo(view)
            make.height.equalTo(240)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        super.updateViewConstraints()
    }
    
    func completeInputPassword() {
        if isInputingRepeatPassword {
            if simplePassword == inputPassword {
                let alertController = CustomAlertViewController(title: "간편비밀번호가 등록되었습니다.",
                                                                message: nil,
                                                                firstActionTitle: "확인") {
                    self.dismiss(animated: true, completion: nil)
                }
                alertController.alertShow(parent: self)
            } else {
                
            }
        } else {
            passwordStackView.arrangedSubviews.forEach { subView in
                guard let button = subView as? UIButton else { return }
                button.isSelected = false
            }
            
            descriptionLabel.isHidden = false
            isInputingRepeatPassword = true
            simplePassword = inputPassword
            inputPassword = ""
        }
    }
}

extension SimplePasswordViewController: PasswordProtocol {
    func backwardAction() {
        if inputPassword.count > 0 {
            _ = inputPassword.popLast()
            guard let button = passwordStackView.arrangedSubviews[simplePassword.count] as? UIButton else { return }
            button.isSelected = false
        }
    }
    
    func numberAction(sender: UIButton) {
        for v in passwordStackView.arrangedSubviews {
            guard let button = v as? UIButton, let numberString = sender.titleLabel?.text else { return }
            if button.isSelected == false {
                button.isSelected = true
                inputPassword.append(numberString)
                if inputPassword.count == 6 {
                    completeInputPassword()
                }
                return
            }
        }
    }
}
