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
    
    let idTextField = SkyFloatingLabelTextField.createTextField(placeholder: "아이디를 입력해주세요.").then {
        $0.title = "아이디 입력"
    }
    
    let passwordTextField = SkyFloatingLabelTextField.createTextField(placeholder: "비밀번호를 입력해주세요").then {
        $0.title = "비밀번호 입력"
    }
    
    // MARK: Variables
    var disposeBag = DisposeBag()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(idTextField)
        view.addSubview(passwordTextField)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(118)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(80)
            make.left.right.equalTo(titleLabel)
            make.height.equalTo(60)
        }
        
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(50)
            make.left.right.equalTo(titleLabel)
            make.height.equalTo(60)
        }
        
        super.updateViewConstraints()
    }
}
