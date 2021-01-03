//
//  RegisterViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/02.
//

import Then
import SnapKit
import TextFieldEffects
import UIKit

class RegisterViewController: UIViewController {
    // MARK: Constants
    let topLabel = UILabel().then {
        $0.text = "회원가입"
    }
    
    let titleLabel = UILabel().then {
        $0.text = "아이디를 입력해주세요."
        $0.font = UIFont.systemFont(ofSize: 20)
    }
    
    // 아이디
    let idView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let idTextField = HoshiTextField().then {
        $0.placeholder = "아이디"
        $0.borderInactiveColor = .gray
    }
    
    let idValidLabel = UILabel().then {
        $0.text = "이미 있는 아이디입니다."
        $0.textColor = .orange
    }
    
    // 비밀번호
    let pwdView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let pwdTextField = HoshiTextField().then {
        $0.placeholder = "비밀번호"
        $0.borderInactiveColor = .gray
    }
    
    let pwdValidLabel = UILabel().then {
        $0.text = "비밀번호가 올바르지 않습니다."
        $0.textColor = .orange
    }
    
    // 비밀번호 확인
    
    // 중복 확인
    let doubleCheckButton = UIButton().then {
        $0.setTitle("중복확인", for: .normal)
        $0.setTitleColor(.red, for: .normal)
        $0.addTarget(self, action: #selector(doubleCheckBtnTouched), for: .touchUpInside)
    }
    
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        setUI()
        
        idView.isHidden = true
    }
    
    @objc
    func doubleCheckBtnTouched() {
//        pwdView.isHidden = false
//        UIView.animate(withDuration: 1) { [weak self] in
//            self?.view.layoutIfNeeded()
//        } completion: { b in
//
//        }
        
        UIView.transition(with: idView, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            self?.idView.isHidden = false
                          })
    }
    
    func setUI() {
        view.addSubview(topLabel)
        view.addSubview(titleLabel)
        
        view.addSubview(idView)
        idView.addSubview(idTextField)
        idView.addSubview(idValidLabel)
        
        view.addSubview(pwdView)
        pwdView.addSubview(pwdTextField)
        pwdView.addSubview(pwdValidLabel)
        
        view.addSubview(doubleCheckButton)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(70)
            make.left.equalTo(topLabel)
        }
        
        idView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.left.equalTo(titleLabel)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
            make.height.equalTo(90)
        }
        
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(idView.snp.top)
            make.left.right.equalTo(idView)
            make.height.equalTo(60)
        }

        idValidLabel.snp.makeConstraints { make in
            make.bottom.equalTo(idView.snp.bottom)
            make.left.equalTo(idView).offset(5)
        }
        
        pwdView.snp.makeConstraints { make in
            make.top.equalTo(idView.snp.bottom).offset(15)
            make.left.equalTo(titleLabel)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
            make.height.equalTo(90)
        }
        
        pwdTextField.snp.makeConstraints { make in
            make.top.equalTo(pwdView.snp.top)
            make.left.right.equalTo(pwdView)
            make.height.equalTo(60)
        }

        pwdValidLabel.snp.makeConstraints { make in
            make.bottom.equalTo(pwdView.snp.bottom)
            make.left.equalTo(pwdView).offset(5)
        }
        
        doubleCheckButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalTo(view)
        }
        
        super.updateViewConstraints()
    }
}
