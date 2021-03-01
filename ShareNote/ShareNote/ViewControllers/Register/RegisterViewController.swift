//
//  RegisterViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/02.
//

import PanModal
import ReactorKit
import SkyFloatingLabelTextField
import SnapKit
import Then
import UIKit

class RegisterViewController: UIViewController, View {
    // MARK: Constants
    let closeButton = UIButton().then {
        $0.setImage(UIImage(named: "icClose"), for: .normal)
        $0.setImage(UIImage(named: "icClose"), for: .highlighted)
    }
    
    let topLabel = UILabel().then {
        $0.text = "회원가입"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 12, style: .Regular)
    }
    
    let titleLabel = UILabel().then {
        $0.text = "아이디를 입력해주세요."
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 24, style: .Regular)
    }
    
    // 이메일
    let emailContainerView = UIView().then {
        $0.isHidden = true
    }
    
    let emailIDTextField = SkyFloatingLabelTextField.createTextField(placeholder: "이메일 입력").then {
        $0.adjustsFontSizeToFitWidth = true
    }
    
    let atLabel = UILabel().then {
        $0.text = "@"
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = .black
    }
    
    let emailAddressTextField = SkyFloatingLabelTextField.createTextField(placeholder: "이메일 선택")
    
    // 비밀번호 확인
    let confirmPasswordContainerView = UIView().then {
        $0.isHidden = true
    }
    
    let confirmPasswordTextField = SkyFloatingLabelTextField.createTextField(placeholder: "비밀번호 확인")
    
    let confirmPasswordValidLabel = UILabel().then {
        $0.text = "비밀번호가 올바르지 않습니다."
        $0.font = UIFont.systemFont(ofSize: 11)
        $0.textColor = .orange
    }
    
    // 비밀번호
    let passwordContainerView = UIView().then {
        $0.isHidden = true
    }
    
    let passwordTextField = SkyFloatingLabelTextField.createTextField(placeholder: "비밀번호 입력")
    
    let passwordValidLabel = UILabel().then {
        $0.text = "비밀번호가 올바르지 않습니다."
        $0.font = UIFont.systemFont(ofSize: 11)
        $0.textColor = .orange
    }
    
    // 아이디
    let idContainerView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let idTextField = SkyFloatingLabelTextField.createTextField(placeholder: "아이디 입력")
    
    let idValidLabel = UILabel().then {
        $0.text = "이미 있는 아이디입니다."
        $0.font = UIFont.systemFont(ofSize: 11)
        $0.textColor = .orange
    }
    
    // 중복 확인 버튼
    let bottomContainerView = UIView().then {
        $0.backgroundColor = .yellow
    }
    
    let doubleCheckButton = UIButton().then {
        $0.setTitle("중복확인", for: .normal)
        $0.setTitleColor(.black2, for: .normal)
        $0.backgroundColor = .mainColor
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 16)
        $0.addTarget(self, action: #selector(doubleCheckBtnTouched), for: .touchUpInside)
    }
    
    // MARK: Variables
    var disposeBag = DisposeBag()
    
    var emailContainerViewHeight: Constraint?
    
    var confirmPasswordContainerViewHeight: Constraint?
    
    var passwordContainerViewHeight: Constraint?
    
    var idContainerViewHeight: Constraint?
    
    var bottomContainerViewBottomConstraint: Constraint?
    
    // MARK: Methods
    override func viewDidLoad() {
        self.reactor = RegisterReactor()
        
        view.backgroundColor = .white
        
        setUI()
        setKeyboardNotification()
        
//        nextButton.rx.tap
//            .bind { [weak self] in
//                self?.nextBtnTouched()
//            }.disposed(by: disposeBag)
    }
    
//    func nextBtnTouched() {
//        UIView.transition(with: scrollContentView, duration: 1, options: .transitionCrossDissolve, animations: { [self] in
//            switch count {
//            case 0:
//                self.birthDataContainerView.isHidden = false
//                self.birthDataContainerViewHeight?.update(offset: 110)
//                self.birthDataTextField.becomeFirstResponder()
//            case 1:
//                self.phoneNumberContainerView.isHidden = false
//                self.phoneNumberContainerViewHeight?.update(offset: 110)
//                self.phoneNumberTextField.becomeFirstResponder()
//            case 2:
//                self.termsAndConditionsContainerView.isHidden = false
//                self.termsAndConditionsContainerViewHeight?.update(offset: 232)
//            default:
//                break
//            }
//        }, completion: { _ in
//            self.count += 1
//        })
//    }
    
    func bind(reactor: RegisterReactor) {
        // Action
        emailIDTextField.rx.text
            .map { RegisterReactor.Action.emailIDTextChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        emailAddressTextField.rx.text
            .map { RegisterReactor.Action.emailAddressTextChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .map { RegisterReactor.Action.passwordTextChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        confirmPasswordTextField.rx.text
            .map { RegisterReactor.Action.confirmPasswordTextChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        idTextField.rx.text
            .map { RegisterReactor.Action.idTextChanged($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    @objc
    func doubleCheckBtnTouched() {
        presentPanModal(EmailTableViewController())
    }
    
    func setUI() {
        view.addSubview(closeButton)
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

        view.addSubview(bottomContainerView)
        bottomContainerView.addSubview(doubleCheckButton)

        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(39)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.width.height.equalTo(30)
        }
        
        // Top Label
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(15)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }

        // Title Label
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(19)
            make.left.right.equalTo(topLabel)
        }
        
        // 이메일
        emailContainerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(106)
            make.left.right.equalTo(topLabel)
            emailContainerViewHeight = make.height.equalTo(0).constraint
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
            confirmPasswordContainerViewHeight = make.height.equalTo(0).constraint
        }
        
        confirmPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordContainerView.snp.top)
            make.left.right.equalTo(confirmPasswordContainerView)
            make.height.equalTo(60)
        }
        
        confirmPasswordValidLabel.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(5)
            make.left.equalTo(confirmPasswordContainerView)
        }
        
        // 비밀번호
        passwordContainerView.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordContainerView.snp.bottom)
            make.left.right.equalTo(topLabel)
            passwordContainerViewHeight = make.height.equalTo(0).constraint
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordContainerView.snp.top)
            make.left.right.equalTo(passwordContainerView)
            make.height.equalTo(60)
        }

        passwordValidLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(5)
            make.left.equalTo(passwordContainerView)
        }

        // 아이디
        idContainerView.snp.makeConstraints { make in
            make.top.equalTo(passwordContainerView.snp.bottom)
            make.left.right.equalTo(topLabel)
            idContainerViewHeight = make.height.equalTo(140).constraint
        }

        idTextField.snp.makeConstraints { make in
            make.top.equalTo(idContainerView.snp.top)
            make.left.right.equalTo(idContainerView)
            make.height.equalTo(60)
        }

        idValidLabel.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(5)
            make.left.equalTo(idContainerView)
        }
        
        // 중복 확인 버튼
        bottomContainerView.snp.makeConstraints { make in
            bottomContainerViewBottomConstraint = make.bottom.equalTo(view).constraint
            make.left.right.equalTo(view)
            make.height.equalTo(45)
        }
        
        doubleCheckButton.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(bottomContainerView)
        }
        
        super.updateViewConstraints()
    }
    
    func setKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
//        self.nextAndCancelContainerView.isHidden = false
//
        self.bottomContainerViewBottomConstraint?.update(offset: -keyboardFrame.size.height)
//        self.nextAndCancelContainerView.updateConstraints()
        
        UIView.animate(withDuration: 1, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
//        nextAndCancelContainerView.isHidden = true
        bottomContainerViewBottomConstraint?.update(offset: 0)
    }
}
