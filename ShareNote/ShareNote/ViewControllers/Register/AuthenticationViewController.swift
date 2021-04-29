//
//  AuthenticationViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/02/12.
//

import RxSwift
import SkyFloatingLabelTextField
import SnapKit
import TextFieldEffects
import UIKit
import PanModal

class AuthenticationViewController: UIViewController {
    
    // MARK: Constants
    let closeButton = UIButton().then {
        $0.setImage(UIImage(named: "icClose"), for: .normal)
        $0.addTarget(self, action: #selector(test), for: .touchUpInside)
    }
    
    let navigationLabel = UILabel().then {
        $0.text = "본인인증"
        $0.font = UIFont.spoqaHanSans(size: 12, style: .Regular)
        $0.textColor = UIColor.black2
    }
    
    let descriptionLabel = UILabel().then {
        $0.text = "휴대폰 번호를 입력해주세요."
        $0.font = UIFont.spoqaHanSans(size: 24, style: .Regular)
        $0.textColor = UIColor.black2
    }
    
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    let scrollContentView = UIView()
    
    // 약관동의 View
    let termsAndConditionsContainerView = UIView().then {
        $0.isHidden = true
    }
    
    let allAgreementButton = UIButton.createCheckButton()
    
    let allAgreementLabel = UILabel().then {
        $0.text = "전체동의"
        $0.font = UIFont.spoqaHanSans(size: 18, style: .Regular)
        $0.textColor = UIColor.black1
    }
    
    let termsAndConditionsButton = UIButton.createCheckButton()
    
    let termsAndConditionsLabel = UILabel.createAttributeLabel(text: "이용약관동의 (필수)")
        
    let infomationReceiveButton = UIButton.createCheckButton()
    
    let infomationReceiveLabel = UILabel.createAttributeLabel(text: "투자 관련 에세이 등 정보 수신 동의 (선택)")
    
    let snsButton = UIButton.createCheckButton()
    
    let smsLabel = UILabel().then {
        $0.text = "SMS"
        $0.font = UIFont.spoqaHanSans(size: 16, style: .Regular)
        $0.textColor = UIColor.black1
    }
    
    let emailButton = UIButton.createCheckButton()
    
    let emailLabel = UILabel().then {
        $0.text = "이메일"
        $0.font = UIFont.spoqaHanSans(size: 16, style: .Regular)
        $0.textColor = UIColor.black1
    }
    
    let overFourteenYearButton = UIButton.createCheckButton()
    
    let overFourteenYearLabel = UILabel.createAttributeLabel(text: "만 14세 이상입니다. (필수)")
    
    let phoneNumberContainerView = UIView().then {
        $0.isHidden = true
    }
    
    let phoneNumberTextField = SkyFloatingLabelTextField.createTextField(placeholder: "휴대폰번호(-없이 입력)")
    
    let phoneNumberErrorLabel = UILabel().then {
        $0.text = "올바르지 않은 형식입니다."
        $0.textColor = .red
        $0.font = UIFont.spoqaHanSans(size: 12, style: .Regular)
    }
    
    let birthDateContainerView = UIView().then {
        $0.isHidden = true
    }
    
    let birthDateTextField = SkyFloatingLabelTextField.createTextField(placeholder: "생년월일 입력")
    
    let divideLabel = UILabel().then {
        $0.text = "-"
        $0.textColor = .grey4
        $0.font = UIFont.spoqaHanSans(size: 20)
    }
    
    let genderTextField = SkyFloatingLabelTextField.createTextField(placeholder: nil).then {
        $0.textAlignment = .center
    }
    
    let dotStackView = UIStackView().then {
        for _ in 0..<6 {
            let image = UIImage(named: "dot")
            let imageView = UIImageView(image: image)
            $0.addArrangedSubview(imageView)
        }
        
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.spacing = 4
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let nameContainerView = UIView()
    
    let nameTextField = SkyFloatingLabelTextField.createTextField(placeholder: "이름 입력")
    
    let nextAndCancelContainerView = UIView().then {
        $0.isHidden = true
        $0.backgroundColor = UIColor.whiteTwo
    }
    
    let nextButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
        $0.setTitleColor(.grey2, for: .normal)
    }
    
    let cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
        $0.setTitleColor(.grey2, for: .normal)
    }
    
    let certificationNumberButton = BottomButtonView(title: "임시 비밀번호 받기")
    
    // MARK: Variables
    var termsAndConditionsContainerViewHeight: Constraint?
    
    var phoneNumberContainerViewHeight: Constraint?
    
    var birthDateContainerViewHeight: Constraint?
    
    var nextAndCancelContainerViewHeight: Constraint?
    
    var disposeBag = DisposeBag()
    
    var count = 0
     
    // MARK: Methods
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        setUI()
        setKeyboardNotification()
        
        closeButton.rx.tap
            .bind { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            }.disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind { [weak self] in
                self?.nextBtnTouched()
            }.disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .bind { [weak self] in
                self?.view.endEditing(true)
            }.disposed(by: disposeBag)
        
        certificationNumberButton.button.rx.tap
            .bind { [weak self] in
                self?.presentPanModal(CertificationNumberViewController())                
            }.disposed(by: disposeBag)
        
        allAgreementButton.rx.tap
            .bind { [weak self] in
                self?.view.endEditing(true)
                self?.allAgreementButton.isSelected.toggle()
            }.disposed(by: disposeBag)
        
        termsAndConditionsButton.rx.tap
            .bind { [weak self] in
                self?.view.endEditing(true)
                self?.termsAndConditionsButton.isSelected.toggle()
            }.disposed(by: disposeBag)
        
        infomationReceiveButton.rx.tap
            .bind { [weak self] in
                self?.view.endEditing(true)
                self?.infomationReceiveButton.isSelected.toggle()
            }.disposed(by: disposeBag)
        
        snsButton.rx.tap
            .bind { [weak self] in
                self?.view.endEditing(true)
                self?.snsButton.isSelected.toggle()
            }.disposed(by: disposeBag)
        
        emailButton.rx.tap
            .bind { [weak self] in
                self?.view.endEditing(true)
                self?.emailButton.isSelected.toggle()
            }.disposed(by: disposeBag)
        
        overFourteenYearButton.rx.tap
            .bind { [weak self] in
                self?.view.endEditing(true)
                self?.overFourteenYearButton.isSelected.toggle()
            }.disposed(by: disposeBag)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        self.nextAndCancelContainerView.isHidden = false
                
        self.nextAndCancelContainerViewHeight?.update(offset: -keyboardFrame.size.height)
        self.nextAndCancelContainerView.updateConstraints()
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
        
        setTextFieldContentOffset()
    }
    
    func setTextFieldContentOffset() {
        if nameTextField.isFirstResponder {
            if nameContainerView.frame.origin.y + nameContainerView.frame.height > nextAndCancelContainerView.frame.origin.y {
                let y = nameContainerView.frame.origin.y + nameContainerView.frame.height + 50 - nextAndCancelContainerView.frame.origin.y
                scrollView.setContentOffset(CGPoint(x: 0, y: y), animated: true)
            }
        } else if birthDateTextField.isFirstResponder || genderTextField.isFirstResponder {
            if birthDateContainerView.frame.origin.y + birthDateContainerView.frame.height > nextAndCancelContainerView.frame.origin.y {
                let y = birthDateContainerView.frame.origin.y + birthDateContainerView.frame.height - nextAndCancelContainerView.frame.origin.y
                scrollView.setContentOffset(CGPoint(x: 0, y: y), animated: true)
            }
        } else if phoneNumberTextField.isFirstResponder {
            if phoneNumberContainerView.frame.origin.y + phoneNumberContainerView.frame.height > nextAndCancelContainerView.frame.origin.y {
                let y = phoneNumberContainerView.frame.origin.y + phoneNumberContainerView.frame.height - nextAndCancelContainerView.frame.origin.y
                scrollView.setContentOffset(CGPoint(x: 0, y: y), animated: true)
            }
        }
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
        certificationNumberButton.isHidden = false
        nextAndCancelContainerView.isHidden = true
        nextAndCancelContainerViewHeight?.update(offset: 0)
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    @objc
    func test() {
        UIView.transition(with: scrollContentView, duration: 1, options: .transitionCrossDissolve, animations: {
            self.termsAndConditionsContainerView.isHidden = false
            self.termsAndConditionsContainerViewHeight?.update(offset: 232)
        }, completion: nil)
    }
    
    func nextBtnTouched() {
        UIView.transition(with: scrollContentView, duration: 1, options: .transitionCrossDissolve, animations: { [self] in
            switch count {
            case 0:
                self.birthDateContainerView.isHidden = false
                self.birthDateContainerViewHeight?.update(offset: 110)
                self.birthDateTextField.becomeFirstResponder()
            case 1:
                self.phoneNumberContainerView.isHidden = false
                self.phoneNumberContainerViewHeight?.update(offset: 110)
                self.phoneNumberTextField.becomeFirstResponder()
            case 2:
                self.termsAndConditionsContainerView.isHidden = false
                self.termsAndConditionsContainerViewHeight?.update(offset: 232)
            default:
                break
            }
        }, completion: { _ in
            self.count += 1
        })
    }
    
    func setUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        
        scrollContentView.addSubview(closeButton)
        scrollContentView.addSubview(navigationLabel)
        scrollContentView.addSubview(descriptionLabel)
        
        scrollContentView.addSubview(termsAndConditionsContainerView)
        termsAndConditionsContainerView.addSubview(allAgreementButton)
        termsAndConditionsContainerView.addSubview(allAgreementLabel)
        termsAndConditionsContainerView.addSubview(termsAndConditionsButton)
        termsAndConditionsContainerView.addSubview(termsAndConditionsLabel)
        termsAndConditionsContainerView.addSubview(infomationReceiveButton)
        termsAndConditionsContainerView.addSubview(infomationReceiveLabel)
        termsAndConditionsContainerView.addSubview(snsButton)
        termsAndConditionsContainerView.addSubview(smsLabel)
        termsAndConditionsContainerView.addSubview(emailButton)
        termsAndConditionsContainerView.addSubview(emailLabel)
        termsAndConditionsContainerView.addSubview(overFourteenYearButton)
        termsAndConditionsContainerView.addSubview(overFourteenYearLabel)
        
        scrollContentView.addSubview(phoneNumberContainerView)
        phoneNumberContainerView.addSubview(phoneNumberTextField)
        phoneNumberContainerView.addSubview(phoneNumberErrorLabel)
        
        scrollContentView.addSubview(birthDateContainerView)
        birthDateContainerView.addSubview(birthDateTextField)
        birthDateContainerView.addSubview(divideLabel)
        birthDateContainerView.addSubview(genderTextField)
        birthDateContainerView.addSubview(dotStackView)
        
        scrollContentView.addSubview(nameContainerView)
        nameContainerView.addSubview(nameTextField)
        
        view.addSubview(nextAndCancelContainerView)
        nextAndCancelContainerView.addSubview(nextButton)
        nextAndCancelContainerView.addSubview(cancelButton)
        
        view.addSubview(certificationNumberButton)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.top.left.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(860)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(scrollContentView).offset(39)
            make.left.equalTo(scrollContentView).offset(15)
            make.width.height.equalTo(30)
        }
        
        navigationLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(15)
            make.left.equalTo(scrollContentView).offset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationLabel.snp.bottom).offset(19)
            make.left.equalTo(scrollContentView).offset(20)
        }
        
        termsAndConditionsContainerView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(113)
            make.left.right.equalTo(scrollContentView)
            self.termsAndConditionsContainerViewHeight = make.height.equalTo(0).constraint
        }
        
        allAgreementButton.snp.makeConstraints { make in
            make.top.equalTo(termsAndConditionsContainerView)
            make.left.equalTo(termsAndConditionsContainerView).offset(20)
            make.width.height.equalTo(20)
        }
        
        allAgreementLabel.snp.makeConstraints { make in
            make.left.equalTo(allAgreementButton.snp.right).offset(10)
            make.centerY.equalTo(allAgreementButton)
        }
        
        termsAndConditionsButton.snp.makeConstraints { make in
            make.top.equalTo(allAgreementButton.snp.bottom).offset(31)
            make.left.equalTo(termsAndConditionsContainerView).offset(20)
            make.width.height.equalTo(20)
        }
        
        termsAndConditionsLabel.snp.makeConstraints { make in
            make.left.equalTo(termsAndConditionsButton.snp.right).offset(10)
            make.centerY.equalTo(termsAndConditionsButton)
        }
        
        infomationReceiveButton.snp.makeConstraints { make in
            make.top.equalTo(termsAndConditionsButton.snp.bottom).offset(21)
            make.left.equalTo(termsAndConditionsContainerView).offset(20)
            make.width.height.equalTo(20)
        }
        
        infomationReceiveLabel.snp.makeConstraints { make in
            make.left.equalTo(infomationReceiveButton.snp.right).offset(10)
            make.centerY.equalTo(infomationReceiveButton)
        }
        
        snsButton.snp.makeConstraints { make in
            make.top.equalTo(infomationReceiveButton.snp.bottom).offset(10)
            make.left.equalTo(termsAndConditionsContainerView).offset(50)
            make.width.height.equalTo(20)
        }
        
        smsLabel.snp.makeConstraints { make in
            make.left.equalTo(snsButton.snp.right).offset(10)
            make.right.equalTo(emailButton.snp.left).offset(-10)
            make.centerY.equalTo(snsButton)
        }
        
        emailButton.snp.makeConstraints { make in
            make.top.equalTo(infomationReceiveButton.snp.bottom).offset(10)
            make.left.equalTo(snsButton.snp.right).offset(72)
            make.width.height.equalTo(20)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.left.equalTo(emailButton.snp.right).offset(10)
            make.centerY.equalTo(emailButton)
        }
        
        overFourteenYearButton.snp.makeConstraints { make in
            make.top.equalTo(snsButton.snp.bottom).offset(21)
            make.left.equalTo(termsAndConditionsContainerView).offset(20)
            make.width.height.equalTo(20)
        }
        
        overFourteenYearLabel.snp.makeConstraints { make in
            make.left.equalTo(overFourteenYearButton.snp.right).offset(10)
            make.centerY.equalTo(overFourteenYearButton)
        }
        
        phoneNumberContainerView.snp.makeConstraints { make in
            make.top.equalTo(termsAndConditionsContainerView.snp.bottom)
            make.left.equalTo(scrollContentView).offset(20)
            make.right.equalTo(scrollContentView).offset(-20)
            self.phoneNumberContainerViewHeight = make.height.equalTo(0).constraint
        }
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.left.right.equalTo(phoneNumberContainerView)
            make.height.equalTo(60)
        }
        
        phoneNumberErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(5)
            make.left.right.equalTo(phoneNumberContainerView)
            make.height.equalTo(15)
        }
        
        birthDateContainerView.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberContainerView.snp.bottom)
            make.left.equalTo(scrollContentView).offset(20)
            make.right.equalTo(scrollContentView).offset(-20)
            self.birthDateContainerViewHeight = make.height.equalTo(0).constraint
        }
        
        birthDateTextField.snp.makeConstraints { make in
            make.left.equalTo(birthDateContainerView)
            make.right.equalTo(divideLabel.snp.left).offset(-5)
            make.height.equalTo(60)
        }
        
        divideLabel.snp.makeConstraints { make in
            make.right.equalTo(genderTextField.snp.left).offset(-5)
            make.bottom.equalTo(genderTextField).offset(-10)
            make.width.equalTo(10)
        }
        
        genderTextField.snp.makeConstraints { make in
            make.right.equalTo(dotStackView.snp.left).offset(-5)
            make.width.equalTo(20)
            make.height.equalTo(60)
        }
        
        dotStackView.snp.makeConstraints { make in
            make.right.equalTo(birthDateContainerView).offset(-5)
            make.centerY.equalTo(divideLabel)
            make.width.equalTo(50)
            make.height.equalTo(5)
        }
        
        nameContainerView.snp.makeConstraints { make in
            make.top.equalTo(birthDateContainerView.snp.bottom)
            make.left.equalTo(scrollContentView).offset(20)
            make.right.equalTo(scrollContentView).offset(-20)
            make.height.equalTo(60)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.left.right.equalTo(nameContainerView)
            make.height.equalTo(60)
        }
        
        nextAndCancelContainerView.snp.makeConstraints { make in
            make.left.right.equalTo(scrollContentView)
            make.height.equalTo(45)
            self.nextAndCancelContainerViewHeight = make.bottom.equalTo(view).constraint
        }
        
        nextButton.snp.makeConstraints { make in
            make.right.equalTo(nextAndCancelContainerView).offset(-20)
            make.centerY.equalTo(nextAndCancelContainerView)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.left.equalTo(nextAndCancelContainerView).offset(20)
            make.centerY.equalTo(nextAndCancelContainerView)
        }
        
        certificationNumberButton.snp.makeConstraints { make in
            make.left.bottom.right.equalTo(view)
            let height = 59 + (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0)
            make.height.equalTo(height)
        }
        
        super.updateViewConstraints()
    }
}
