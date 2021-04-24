//
//  FindPasswordViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/04/24.
//

import RxSwift
import SkyFloatingLabelTextField
import SnapKit
import UIKit

class FindPasswordViewController: UIViewController {

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
        $0.text = "비밀번호 찾기"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 12, style: .Regular)
    }
    
    let titleLabel = UILabel().then {
        $0.text = "아이디를 입력해주세요."
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 24, style: .Regular)
    }
    
    let descriptionLabel = UILabel().then {
        $0.text = "등록하신 핸드폰 번호로 임시 비밀번호가 발급됩니다."
        $0.textColor = .grey4
        $0.font = UIFont.spoqaHanSans(size: 12, style: .Regular)
    }
    
    // 휴대폰번호
    let phoneNumberTextFieldContainerView = UIView().then {
        $0.isHidden = true
    }
    
    let phoneNumberTextField = SkyFloatingLabelTextField.createTextField(placeholder: "휴대폰번호(-없이 입력)").then {
        $0.title = "휴대폰번호"
    }
    
    // 이름 입력
    let nameTextFieldContainerView = UIView().then {
        $0.isHidden = true
    }
    
    let nameTextField = SkyFloatingLabelTextField.createTextField(placeholder: "이름 입력")
    
    // 아이디
    let idContainerView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let idTextField = SkyFloatingLabelTextField.createTextField(placeholder: "아이디 입력")
    
    let receiveButton = BottomButtonView(title: "임시 비밀번호 받기")
    
    let moveButtonContainerView = MoveButtonContainerView().then {
        $0.isHidden = true
        $0.nextButton.addTarget(self, action: #selector(nextBtnTouched), for: .touchUpInside)
        $0.cancelButton.addTarget(self, action: #selector(viewTouched), for: .touchUpInside)
    }
    
    // MARK: Variables
    var phoneNumberContainerViewHeight: Constraint?
    
    var passwordContainerViewHeight: Constraint?
    
    var idContainerViewHeight: Constraint?
    
    var bottomContainerViewBottomConstraint: Constraint?
    
    var count = 0
    
    var disposeBag = DisposeBag()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setKeyboardNotification()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTouched)))
        
        idTextField.delegate = self
        nameTextField.delegate = self
        phoneNumberTextField.delegate = self
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        
        scrollContentView.addSubview(closeButton)
        scrollContentView.addSubview(topLabel)
        scrollContentView.addSubview(titleLabel)
        scrollContentView.addSubview(descriptionLabel)
        
        scrollContentView.addSubview(phoneNumberTextFieldContainerView)
        phoneNumberTextFieldContainerView.addSubview(phoneNumberTextField)
        
        scrollContentView.addSubview(nameTextFieldContainerView)
        nameTextFieldContainerView.addSubview(nameTextField)
        
        scrollContentView.addSubview(idContainerView)
        idContainerView.addSubview(idTextField)
        
        scrollContentView.addSubview(receiveButton)
        scrollContentView.addSubview(moveButtonContainerView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view)
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
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalTo(topLabel)
        }
        
        // 휴대폰 번호
        phoneNumberTextFieldContainerView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(80)
            make.left.right.equalTo(topLabel)
            phoneNumberContainerViewHeight = make.height.equalTo(0).constraint
        }
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextFieldContainerView.snp.top)
            make.left.right.equalTo(phoneNumberTextFieldContainerView)
            make.height.equalTo(60)
        }
        
        // 비밀번호
        nameTextFieldContainerView.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextFieldContainerView.snp.bottom)
            make.left.right.equalTo(topLabel)
            passwordContainerViewHeight = make.height.equalTo(0).constraint
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextFieldContainerView.snp.top)
            make.left.right.equalTo(nameTextFieldContainerView)
            make.height.equalTo(60)
        }
        
        // 아이디
        idContainerView.snp.makeConstraints { make in
            make.top.equalTo(nameTextFieldContainerView.snp.bottom)
            make.left.right.equalTo(topLabel)
            idContainerViewHeight = make.height.equalTo(110).constraint
        }
        
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(idContainerView.snp.top)
            make.left.right.equalTo(idContainerView)
            make.height.equalTo(60)
        }
        
        receiveButton.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view)
            let height = 59 + view.safeAreaInsets.bottom
            make.height.equalTo(height)
        }
        
        moveButtonContainerView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            bottomContainerViewBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide).constraint
            make.height.equalTo(45)
        }
        
        super.updateViewConstraints()
    }
    
    @objc
    func viewTouched() {
        view.endEditing(true)
    }
    
    @objc
    func nextBtnTouched() {
        if idTextField.isFirstResponder {
            self.nameTextFieldContainerView.isHidden = false
            self.passwordContainerViewHeight?.update(offset: 110)
            nameTextField.becomeFirstResponder()
        } else if nameTextField.isFirstResponder {
            self.phoneNumberTextFieldContainerView.isHidden = false
            self.phoneNumberContainerViewHeight?.update(offset: 110)
            phoneNumberTextField.becomeFirstResponder()
        } else if phoneNumberTextField.isFirstResponder {
            view.endEditing(true)
        }
    }
    
    func setKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        moveButtonContainerView.isHidden = false
        
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let keyboardBottom = keyboardFrame.size.height - view.safeAreaInsets.bottom
        self.bottomContainerViewBottomConstraint?.update(offset: -keyboardBottom)
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
        moveButtonContainerView.isHidden = true
        
        bottomContainerViewBottomConstraint?.update(offset: 0)
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
}

extension FindPasswordViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        DispatchQueue.main.async { [weak self] in
            guard let containerView = textField.superview else { return }
            let containerViewBottomY = containerView.frame.origin.y + containerView.frame.height
            if containerViewBottomY > (self?.moveButtonContainerView.frame.origin.y)! {
                let y = containerViewBottomY - (self?.moveButtonContainerView.frame.origin.y)!
                self?.scrollView.setContentOffset(CGPoint(x: 0, y: y), animated: true)
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}
