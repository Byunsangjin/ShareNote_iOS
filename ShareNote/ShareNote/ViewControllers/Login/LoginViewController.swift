//
//  LoginViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/01.
//

import ReactorKit
import RxSwift
import SkyFloatingLabelTextField
import SnapKit
import Then
import UIKit

class LoginViewController: UIViewController {
    
    // MARK: Constants
    let titleLabel = UILabel().then {
        $0.text = "건강한 주식투자를\n시작해볼까요?"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 24, style: .Regular)
        $0.numberOfLines = 0
    }
    
    let passwordContainerView = UIView()
    
    let passwordTextField = SkyFloatingLabelTextField.createTextField(placeholder: "비밀번호를 입력해주세요").then {
        $0.title = "비밀번호 입력"
    }

    let findPasswordButton = UIButton().then {
        let attributeString = NSAttributedString(string: "비밀번호가 기억나지 않습니다.",
                                                 attributes: [NSAttributedString.Key.font : UIFont.spoqaHanSans(size: 12, style: .Regular),
                                                              NSAttributedString.Key.foregroundColor : UIColor.grey4,
                                                              NSAttributedString.Key.underlineStyle : true,
                                                              NSAttributedString.Key.underlineColor : UIColor.grey4])
        $0.setAttributedTitle(attributeString, for: .normal)
    }
    
    let idContainerView = UIView()
    
    let idTextField = SkyFloatingLabelTextField.createTextField(placeholder: "아이디를 입력해주세요.").then {
        $0.title = "아이디 입력"
    }
    
    let findIdButton = UIButton().then {
        let attributeString = NSAttributedString(string: "아이디가 기억나지 않습니다.",
                                                 attributes: [NSAttributedString.Key.font : UIFont.spoqaHanSans(size: 12, style: .Regular),
                                                              NSAttributedString.Key.foregroundColor : UIColor.grey4,
                                                              NSAttributedString.Key.underlineStyle : true,
                                                              NSAttributedString.Key.underlineColor : UIColor.grey4])
        $0.setAttributedTitle(attributeString, for: .normal)
    }
    
    let divideLineView = UIView().then {
        $0.backgroundColor = .grey5
    }
    
    let divideLabel = UILabel().then {
        $0.text = "간편 로그인"
        $0.textColor = .grey5
        $0.font = UIFont.spoqaHanSans(size: 12)
        $0.textAlignment = .center
        
        $0.backgroundColor = .white
    }
    
    let simpleLoginStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 20
        $0.distribution = .fillEqually
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let naverLoginButton = UIButton().then {
        $0.setImage(UIImage(named: "iconLoginNaver"), for: .normal)
    }
    
    let kakaoLoginButton = UIButton().then {
        $0.setImage(UIImage(named: "iconLoginNaver"), for: .normal)
    }
    
    let googleLoginButton = UIButton().then {
        $0.setImage(UIImage(named: "iconLoginNaver"), for: .normal)
    }
    
    let appleLoginButton = UIButton().then {
        $0.setImage(UIImage(named: "iconLoginNaver"), for: .normal)
    }
    
    // MARK: Variables
    var disposeBag = DisposeBag()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        simpleLoginStackView.addArrangedSubview(naverLoginButton)
        simpleLoginStackView.addArrangedSubview(kakaoLoginButton)
        simpleLoginStackView.addArrangedSubview(googleLoginButton)
        simpleLoginStackView.addArrangedSubview(appleLoginButton)
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        
        view.addSubview(passwordContainerView)
        passwordContainerView.addSubview(passwordTextField)
        passwordContainerView.addSubview(findPasswordButton)
        
        view.addSubview(idContainerView)
        idContainerView.addSubview(idTextField)
        idContainerView.addSubview(findIdButton)
        
        view.addSubview(divideLineView)
        view.addSubview(divideLabel)
        
        view.addSubview(simpleLoginStackView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(118)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        passwordContainerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(80)
            make.left.right.equalTo(titleLabel)
            make.height.equalTo(90)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordContainerView)
            make.left.right.equalTo(passwordContainerView)
            make.height.equalTo(60)
        }
        
        findPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(5)
            make.left.equalTo(passwordContainerView)
        }
        
        idContainerView.snp.makeConstraints { make in
            make.top.equalTo(passwordContainerView.snp.bottom).offset(30)
            make.left.right.equalTo(titleLabel)
            make.height.equalTo(90)
        }
        
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(idContainerView)
            make.left.right.equalTo(idContainerView)
            make.height.equalTo(60)
        }

        findIdButton.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(5)
            make.left.equalTo(idContainerView)
        }
        
        divideLineView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-245)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(1)
        }
        
        divideLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(divideLineView)
            make.width.equalTo(98)
        }
        
        simpleLoginStackView.snp.makeConstraints { make in
            make.top.equalTo(divideLabel).offset(35)
            make.centerX.equalTo(view)
            make.width.equalTo(220)
            make.height.equalTo(40)
        }
        
        super.updateViewConstraints()
    }
}
