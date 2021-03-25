//
//  ChangePasswordViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/07.
//

import RxSwift
import UIKit

class ChangePasswordViewController: UIViewController {

    // MARK: Constants
    let navigationView = NavigationView().then {
        $0.titleLabel.text = "비밀번호변경"
    }
    
    let currentPasswordLabel = UILabel().then {
        $0.text = "현재 비밀번호"
        $0.textColor = .black1
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
    }
    
    let currentPasswordTextField = UITextField.createTextField(isSecureTextEntry: true).then {
        $0.placeholder = "현재 비밀번호 입력"
    }
    
    let newPasswordLabel = UILabel().then {
        $0.text = "새 비밀번호"
        $0.textColor = .black1
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
    }
    
    let newPasswordTextField = UITextField.createTextField(isSecureTextEntry: true).then {
        $0.placeholder = "새 비밀번호"
    }
    
    let newPasswordRepeatTextField = UITextField.createTextField(isSecureTextEntry: true).then {
        $0.placeholder = "새 비밀번호 재입력"
    }
    
    let errorLabel = UILabel().then {
        $0.text = "비밀번호가 일치하지 않습니다."
        $0.textColor = .red
        $0.font = UIFont.spoqaHanSans(size: 12, style: .Regular)
    }
    
    let changeButton = UIButton().then {
        $0.setTitle("변경", for: .normal)
        $0.setTitleColor(.grey2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 16)
        $0.backgroundColor = .whiteTwo
        $0.addTarget(self, action: #selector(test), for: .touchUpInside)
        $0.layer.cornerRadius = 7
    }
    
    // MARK: Variables
    var disposeBag = DisposeBag()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        navigationView.leftBarButton.rx.tap
            .bind { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }.disposed(by: disposeBag)
    }
    
    @objc
    func test() {
        let customAlertVC = CustomAlertViewController(title: "비밀번호가 변경되었습니다.",
                                                      message: nil,
                                                      firstActionTitle: "확인",
                                                      firstAction: { [weak self] in
                                                        self?.navigationController?.popViewController(animated: true)
                                                      })
                                                        
        
        customAlertVC.alertShow(parent: self)
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(navigationView)
        
        view.addSubview(currentPasswordLabel)
        view.addSubview(currentPasswordTextField)
        
        view.addSubview(newPasswordLabel)
        view.addSubview(newPasswordTextField)
        view.addSubview(newPasswordRepeatTextField)        
        view.addSubview(errorLabel)
        
        view.addSubview(changeButton)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
        
        currentPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(36)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        currentPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(currentPasswordLabel.snp.bottom).offset(10)
            make.left.right.equalTo(currentPasswordLabel)
            make.height.equalTo(35)
        }
        
        newPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(currentPasswordTextField.snp.bottom).offset(40)
            make.left.right.equalTo(currentPasswordLabel)
        }
        
        newPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(newPasswordLabel.snp.bottom).offset(10)
            make.left.right.equalTo(currentPasswordLabel)
            make.height.equalTo(35)
        }
        
        newPasswordRepeatTextField.snp.makeConstraints { make in
            make.top.equalTo(newPasswordTextField.snp.bottom).offset(25)
            make.left.right.equalTo(currentPasswordLabel)
            make.height.equalTo(35)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(newPasswordRepeatTextField.snp.bottom).offset(10)
            make.left.right.equalTo(currentPasswordLabel)
        }
        
        changeButton.snp.makeConstraints { make in
            make.left.right.equalTo(currentPasswordLabel)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-7)
            make.height.equalTo(45)
        }
        
        super.updateViewConstraints()
    }
}
