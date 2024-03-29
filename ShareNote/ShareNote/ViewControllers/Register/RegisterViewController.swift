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
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    let scrollContentView = UIView()
    
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
        $0.textColor = .grey4
        $0.textAlignment = .center
    }
    
    let emailAddressButton = UIButton().then {
        $0.setTitle("이메일 선택", for: .normal)
        $0.setTitleColor(.black2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 20)
        $0.setImage(UIImage(named: "iconsDropbox"), for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
    }
    
    // 비밀번호 확인
    let confirmPasswordContainerView = UIView().then {
        $0.isHidden = true
    }
    
    let confirmPasswordTextField = SkyFloatingLabelTextField.createTextField(placeholder: "비밀번호 확인").then {
        $0.isSecureTextEntry = true
    }
    
    let confirmPasswordValidLabel = UILabel().then {
        $0.text = "비밀번호가 올바르지 않습니다."
        $0.font = UIFont.systemFont(ofSize: 11)
        $0.textColor = .orange
        $0.isHidden = true
    }
    
    // 비밀번호
    let passwordContainerView = UIView().then {
        $0.isHidden = true
    }
    
    let passwordTextField = SkyFloatingLabelTextField.createTextField(placeholder: "비밀번호 입력").then {
        $0.isSecureTextEntry = true
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
        $0.isHidden = true
    }
    
    // 중복 확인 버튼
    let bottomContainerView = UIView().then {
        $0.backgroundColor = .yellow
        $0.isHidden = true
    }
    
    let doubleCheckButton = UIButton().then {
        $0.setTitle("중복확인", for: .normal)
        $0.setTitleColor(.black2, for: .normal)
        $0.backgroundColor = .mainColor
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 16)
        $0.addTarget(self, action: #selector(doubleCheckBtnTouched), for: .touchUpInside)
    }
    
    let moveButtonContainerView = UIView().then {
        $0.backgroundColor = .whiteTwo
        $0.isHidden = true
    }
    
    let cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.grey2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
    }
    
    let nextButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.grey2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
    }
    
    let completeButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.black2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 16)
        $0.backgroundColor = .mainColor
    }
    
    // MARK: Variables
    var emailContainerViewHeight: Constraint?
    
    var confirmPasswordContainerViewHeight: Constraint?
    
    var passwordContainerViewHeight: Constraint?
    
    var idContainerViewHeight: Constraint?
    
    var bottomContainerViewBottomConstraint: Constraint?
    
    var count = 0
    
    var disposeBag = DisposeBag()
    
    // MARK: Methods
    override func viewDidLoad() {
        self.reactor = RegisterReactor()
        
        view.backgroundColor = .white
        
        setUI()
        setKeyboardNotification()
        
        cancelButton.rx.tap
            .bind { [weak self] in
                self?.view.endEditing(true)
            }.disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind { [weak self] in
                self?.nextBtnTouched()
            }.disposed(by: disposeBag)
        
        emailAddressButton.rx.tap
            .bind { [weak self] in
                self?.view.endEditing(true)
                let emailTableViewController = EmailTableViewController()
                emailTableViewController.delegate = self
                self?.presentPanModal(emailTableViewController)
            }.disposed(by: disposeBag)
        
        closeButton.rx.tap
            .bind { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            }.disposed(by: disposeBag)
        
        idTextField.rx.controlEvent([.editingDidBegin, .editingDidEnd])
            .bind { [weak self] in
                guard let isResponder = self?.idTextField.isFirstResponder else { return }
                self?.doubleCheckButton.isHidden = !isResponder
                self?.moveButtonContainerView.isHidden = isResponder
            }.disposed(by: disposeBag)
        
        passwordTextField.rx.controlEvent([.editingDidBegin, .editingDidEnd])
            .bind { [weak self] in
                guard let isResponder = self?.passwordTextField.isFirstResponder else { return }
                self?.doubleCheckButton.isHidden = isResponder
                self?.moveButtonContainerView.isHidden = !isResponder
            }.disposed(by: disposeBag)
        
        confirmPasswordTextField.rx.controlEvent([.editingDidBegin, .editingDidEnd])
            .bind { [weak self] in
                guard let isResponder = self?.confirmPasswordTextField.isFirstResponder else { return }
                self?.doubleCheckButton.isHidden = isResponder
                self?.moveButtonContainerView.isHidden = !isResponder
            }.disposed(by: disposeBag)
        
        completeButton.rx.tap
            .bind(onNext: { [weak self] in
                guard let member = self?.createMember() else { return }
                NetworkHelper.shared.register(user: member) { isSuccessed in
                    if isSuccessed {
                        let customAlertViewController = CustomAlertViewController(title: "쉐어노트\n회원가입을 축하합니다!",
                                                                                  message: "로그인 후 쉐어노트에서\n금융생활을 기록하세요!",
                                                                                  firstActionTitle: "로그인", firstAction:  {
                                                                                    self?.dismiss(animated: true, completion: nil)
                                                                                  })
                        customAlertViewController.alertShow(parent: self!)
                    } else {
                        logger.error("회원가입 실패")
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    func createMember() -> Member? {
        guard let id = idTextField.text else { return nil }
        guard let password = passwordTextField.text else { return nil }
        guard let emailId = emailIDTextField.text else { return nil }
        guard let emailAddress = emailAddressButton.titleLabel?.text else { return nil }
        let email = "\(emailId)@\(emailAddress)"
        let member = Member(id: id, password: password, email: email)
        
        return member
    }
    
    func nextBtnTouched() {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: { [self] in
            switch count {
            case 0:
                self.passwordContainerView.isHidden = false
                self.passwordContainerViewHeight?.update(offset: 140)
                self.passwordTextField.becomeFirstResponder()
            case 1:
                self.confirmPasswordContainerView.isHidden = false
                self.confirmPasswordContainerViewHeight?.update(offset: 140)
                self.confirmPasswordTextField.becomeFirstResponder()
            case 2:
                self.emailContainerView.isHidden = false
                self.emailContainerViewHeight?.update(offset: 100)
            default:
                break
            }
        }, completion: { _ in
            self.count += 1
        })
    }
    
    func bind(reactor: RegisterReactor) {
        // Action
        emailIDTextField.rx.text
            .map { RegisterReactor.Action.emailIDTextChanged($0) }
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
        
        idTextField.rx.controlEvent([.editingDidEnd])
            .bind { [weak self] in
                self?.doubleCheckButton.isHidden = true
            }.disposed(by: disposeBag)
        
        passwordTextField.rx.controlEvent([.editingDidBegin])
            .bind { [weak self] in
                self?.moveButtonContainerView.isHidden = false
            }.disposed(by: disposeBag)
    }
    
    @objc
    func doubleCheckBtnTouched() {
        guard let id = idTextField.text else { return }
        NetworkHelper.shared.isExistID(userID: id) { [weak self] isExist in
            if isExist {
                self?.idValidLabel.isHidden = false
            } else {
                logger.verbose("사용 가능한 아이디")
                self?.nextBtnTouched()
            }
        }
    }
    
    func setUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        
        scrollContentView.addSubview(closeButton)
        scrollContentView.addSubview(topLabel)
        scrollContentView.addSubview(titleLabel)
        
        scrollContentView.addSubview(emailContainerView)
        emailContainerView.addSubview(emailIDTextField)
        emailContainerView.addSubview(atLabel)
        emailContainerView.addSubview(emailAddressButton)

        scrollContentView.addSubview(confirmPasswordContainerView)
        confirmPasswordContainerView.addSubview(confirmPasswordTextField)
        confirmPasswordContainerView.addSubview(confirmPasswordValidLabel)
        
        scrollContentView.addSubview(passwordContainerView)
        passwordContainerView.addSubview(passwordTextField)
        
        scrollContentView.addSubview(idContainerView)
        idContainerView.addSubview(idTextField)
        idContainerView.addSubview(idValidLabel)

        scrollContentView.addSubview(bottomContainerView)
        bottomContainerView.addSubview(doubleCheckButton)
        
        bottomContainerView.addSubview(moveButtonContainerView)
        moveButtonContainerView.addSubview(cancelButton)
        moveButtonContainerView.addSubview(nextButton)

        scrollContentView.addSubview(completeButton)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.top.left.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(763)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(scrollContentView).offset(39)
            make.left.equalTo(scrollContentView).offset(15)
            make.width.height.equalTo(30)
        }
        
        // Top Label
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(15)
            make.left.equalTo(scrollContentView).offset(20)
            make.right.equalTo(scrollContentView).offset(-20)
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
            make.top.equalTo(emailContainerView).offset(25)
            make.centerX.equalTo(emailContainerView)
            make.width.height.equalTo(30)
        }
        
        emailIDTextField.snp.makeConstraints { make in
            make.top.equalTo(emailContainerView.snp.top)
            make.left.equalTo(emailContainerView)
            make.right.equalTo(atLabel.snp.left).offset(-15)
            make.height.equalTo(60)
        }

        emailAddressButton.snp.makeConstraints { make in
            make.centerY.equalTo(atLabel)
            make.left.equalTo(atLabel.snp.right)
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
            bottomContainerViewBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide).constraint
            make.left.right.equalTo(view)
            make.height.equalTo(45)
        }
        
        doubleCheckButton.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(bottomContainerView)
        }
        
        moveButtonContainerView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(bottomContainerView)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.left.equalTo(moveButtonContainerView).offset(20)
            make.centerY.equalTo(moveButtonContainerView)
        }
        
        nextButton.snp.makeConstraints { make in
            make.right.equalTo(moveButtonContainerView).offset(-20)
            make.centerY.equalTo(moveButtonContainerView)
        }
        
        completeButton.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(59)
        }
        
        super.updateViewConstraints()
    }
    
    func setKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        bottomContainerView.isHidden = false
        
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let keyboardBottom = keyboardFrame.size.height - view.safeAreaInsets.bottom
        self.bottomContainerViewBottomConstraint?.update(offset: -keyboardBottom)
        
        UIView.animate(withDuration: 1, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
        bottomContainerView.isHidden = true
        
        bottomContainerViewBottomConstraint?.update(offset: 0)
        
        UIView.animate(withDuration: 1, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
}

extension RegisterViewController: RegisterDelegate {
    func didSelectEmail(email: String) {
        emailAddressButton.setTitle(email, for: .normal)
    }
}

protocol RegisterDelegate {
    func didSelectEmail(email: String)
}
