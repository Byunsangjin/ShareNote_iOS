//
//  RegisterViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/02.
//

import PanModal
import ReactorKit
import SnapKit
import TextFieldEffects
import Then
import UIKit

class RegisterViewController: UIViewController, View {
    // MARK: Constants
    let topLabel = UILabel().then {
        $0.text = "회원가입"
    }
    
    let titleLabel = UILabel().then {
        $0.text = "아이디를 입력해주세요."
        $0.font = UIFont.systemFont(ofSize: 20)
    }
    
    // 이메일
    let emailContainerView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let emailIDTextField = HoshiTextField().then {
        $0.placeholder = "이메일"
        $0.borderInactiveColor = .gray
        $0.adjustsFontSizeToFitWidth = true
    }
    
    let atLabel = UILabel().then {
        $0.text = "@"
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = .black
    }
    
    let emailAddressTextField = HoshiTextField().then {
        $0.placeholder = "이메일주소"
        $0.borderInactiveColor = .gray
        $0.adjustsFontSizeToFitWidth = true
    }
    
    // 비밀번호 확인
    let confirmPasswordContainerView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let confirmPasswordTextField = HoshiTextField().then {
        $0.placeholder = "비밀번호확인"
        $0.borderInactiveColor = .gray
    }
    
    let confirmPasswordValidLabel = UILabel().then {
        $0.text = "비밀번호가 올바르지 않습니다."
        $0.font = UIFont.systemFont(ofSize: 11)
        $0.textColor = .orange
    }
    
    // 비밀번호
    let passwordContainerView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let passwordTextField = HoshiTextField().then {
        $0.placeholder = "비밀번호"
        $0.borderInactiveColor = .gray
    }
    
    let passwordValidLabel = UILabel().then {
        $0.text = "비밀번호가 올바르지 않습니다."
        $0.font = UIFont.systemFont(ofSize: 11)
        $0.textColor = .orange
    }
    
    // 아이디
    let idContainerView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let idTextField = HoshiTextField().then {
        $0.placeholder = "아이디"
        $0.borderInactiveColor = .gray
    }
    
    let idValidLabel = UILabel().then {
        $0.text = "이미 있는 아이디입니다."
        $0.font = UIFont.systemFont(ofSize: 11)
        $0.textColor = .orange
    }
    
    // 중복 확인 버튼
    let doubleCheckButton = UIButton().then {
        $0.setTitle("중복확인", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .lightGray
        $0.addTarget(self, action: #selector(doubleCheckBtnTouched), for: .touchUpInside)
    }
    
    var disposeBag = DisposeBag()
    
    // MARK: Methods
    override func viewDidLoad() {
        self.reactor = RegisterReactor()
        
        view.backgroundColor = .white
        
        setUI()
    }
    
    func bind(reactor: RegisterReactor) {
        
    }
    
    @objc
    func doubleCheckBtnTouched() {
        presentPanModal(EmailTableViewController())
    }
    
    func setUI() {
        view.addSubview(topLabel)
        view.addSubview(titleLabel)
        
        view.addSubview(emailContainerView)
        emailContainerView.addSubview(emailIDTextField)
        emailContainerView.addSubview(atLabel)
        emailContainerView.addSubview(emailAddressTextField)

        view.addSubview(confirmPasswordContainerView)
        confirmPasswordContainerView.addSubview(confirmPasswordTextField)
        confirmPasswordContainerView.addSubview(confirmPasswordValidLabel)
        
        view.addSubview(passwordContainerView)
        passwordContainerView.addSubview(passwordTextField)
        passwordContainerView.addSubview(passwordValidLabel)
        
        view.addSubview(idContainerView)
        idContainerView.addSubview(idTextField)
        idContainerView.addSubview(idValidLabel)

        view.addSubview(doubleCheckButton)

        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        // Top Label
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
        }

        // Title Label
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(70)
            make.left.right.equalTo(topLabel)
        }
        
        // 이메일
        emailContainerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.left.right.equalTo(topLabel)
            make.height.equalTo(70)
        }
        
        atLabel.snp.makeConstraints { make in
            make.center.equalTo(emailContainerView.snp.center)
            make.width.height.equalTo(30)
        }
        
        emailIDTextField.snp.makeConstraints { make in
            make.top.equalTo(emailContainerView.snp.top)
            make.left.equalTo(emailContainerView)
            make.right.equalTo(atLabel.snp.left).offset(-15)
            make.height.equalTo(60)
        }

        emailAddressTextField.snp.makeConstraints { make in
            make.top.equalTo(emailContainerView.snp.top)
            make.left.equalTo(atLabel.snp.right).offset(15)
            make.right.equalTo(emailContainerView.snp.right)
            make.height.equalTo(60)
        }
        
        // 비밀번호 확인
        confirmPasswordContainerView.snp.makeConstraints { make in
            make.top.equalTo(emailContainerView.snp.bottom)
            make.left.right.equalTo(topLabel)
            make.height.equalTo(80)
        }
        
        confirmPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordContainerView.snp.top)
            make.left.right.equalTo(confirmPasswordContainerView)
            make.height.equalTo(60)
        }
        
        confirmPasswordValidLabel.snp.makeConstraints { make in
            make.bottom.equalTo(confirmPasswordContainerView.snp.bottom)
            make.left.equalTo(confirmPasswordContainerView).offset(5)
        }
        
        // 비밀번호
        passwordContainerView.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordContainerView.snp.bottom)
            make.left.right.equalTo(topLabel)
            make.height.equalTo(80)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordContainerView.snp.top)
            make.left.right.equalTo(passwordContainerView)
            make.height.equalTo(60)
        }

        passwordValidLabel.snp.makeConstraints { make in
            make.bottom.equalTo(passwordContainerView.snp.bottom)
            make.left.equalTo(passwordContainerView).offset(5)
        }

        // 아이디
        idContainerView.snp.makeConstraints { make in
            make.top.equalTo(passwordContainerView.snp.bottom)
            make.left.right.equalTo(topLabel)
            make.height.equalTo(80)
        }

        idTextField.snp.makeConstraints { make in
            make.top.equalTo(idContainerView.snp.top)
            make.left.right.equalTo(idContainerView)
            make.height.equalTo(60)
        }

        idValidLabel.snp.makeConstraints { make in
            make.bottom.equalTo(idContainerView.snp.bottom)
            make.left.equalTo(idContainerView).offset(5)
        }
        
        // 중복 확인 버튼
        doubleCheckButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(40)
        }
        
        super.updateViewConstraints()
    }
}
