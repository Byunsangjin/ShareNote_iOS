//
//  AuthenticationViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/02/12.
//

import TextFieldEffects
import UIKit
import SkyFloatingLabelTextField

class AuthenticationViewController: UIViewController {
    
    // MARK: Constants
    let closeButton = UIButton().then {
        $0.setImage(UIImage(named: "icClose"), for: .normal)
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
    
    let scrollContentView = UIView().then {
        $0.backgroundColor = .grey7
    }
    
    // 약관동의 View
    let termsAndConditionsContainerView = UIView()
    
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
    
    let smsButton = UIButton.createCheckButton()
    
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
    
    let phoneNumberContainerView = UIView()
    
    let phoneNumberTextField = SkyFloatingLabelTextField.createTextField(placeholder: "휴대폰번호(-없이 입력)")
    
    let phoneNumberErrorLabel = UILabel().then {
        $0.text = "올바르지 않은 형식입니다."
        $0.textColor = .red
        $0.font = UIFont.spoqaHanSans(size: 12, style: .Regular)
    }
    
    let birthDataContainerView = UIView()
    
    let birthDataTextField = SkyFloatingLabelTextField.createTextField(placeholder: "생년월일 입력")
    
    let divideLabel = UILabel().then {
        $0.text = "-"
        $0.textColor = .grey4
        $0.font = UIFont.spoqaHanSans(size: 20)
    }
    
    let genderTextField = SkyFloatingLabelTextField.createTextField()
    
    let dotStackView = UIStackView().then {
        let image = UIImage(named: "dot")
        let imageView = UIImageView(image: image)
        
        for _ in 0..<6 {
            $0.addArrangedSubview(imageView)
        }
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        setUI()
    }
    
    func setUI() {
        view.addSubview(closeButton)
        view.addSubview(navigationLabel)
        view.addSubview(descriptionLabel)
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        
        scrollContentView.addSubview(termsAndConditionsContainerView)
        termsAndConditionsContainerView.addSubview(allAgreementButton)
        termsAndConditionsContainerView.addSubview(allAgreementLabel)
        termsAndConditionsContainerView.addSubview(termsAndConditionsButton)
        termsAndConditionsContainerView.addSubview(termsAndConditionsLabel)
        termsAndConditionsContainerView.addSubview(infomationReceiveButton)
        termsAndConditionsContainerView.addSubview(infomationReceiveLabel)
        termsAndConditionsContainerView.addSubview(smsButton)
        termsAndConditionsContainerView.addSubview(smsLabel)
        termsAndConditionsContainerView.addSubview(emailButton)
        termsAndConditionsContainerView.addSubview(emailLabel)
        termsAndConditionsContainerView.addSubview(overFourteenYearButton)
        termsAndConditionsContainerView.addSubview(overFourteenYearLabel)
        
        scrollContentView.addSubview(phoneNumberContainerView)
        phoneNumberContainerView.addSubview(phoneNumberTextField)
        phoneNumberContainerView.addSubview(phoneNumberErrorLabel)
        
        scrollContentView.addSubview(birthDataContainerView)
        birthDataContainerView.addSubview(birthDataTextField)
        birthDataContainerView.addSubview(divideLabel)
        birthDataContainerView.addSubview(genderTextField)
        birthDataContainerView.addSubview(dotStackView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(39)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.width.height.equalTo(30)
        }
        
        navigationLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(15)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationLabel.snp.bottom).offset(19)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(106)
            make.left.width.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.top.left.equalTo(scrollView)
            make.width.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view)
        }
        
        termsAndConditionsContainerView.snp.makeConstraints { make in
            make.top.equalTo(scrollContentView).offset(5)
            make.left.right.equalTo(scrollContentView)
            make.height.equalTo(182)
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
        
        smsButton.snp.makeConstraints { make in
            make.top.equalTo(infomationReceiveButton.snp.bottom).offset(10)
            make.left.equalTo(termsAndConditionsContainerView).offset(50)
            make.width.height.equalTo(20)
        }
        
        smsLabel.snp.makeConstraints { make in
            make.left.equalTo(smsButton.snp.right).offset(10)
            make.right.equalTo(emailButton.snp.left).offset(-10)
            make.centerY.equalTo(smsButton)
        }
        
        emailButton.snp.makeConstraints { make in
            make.top.equalTo(infomationReceiveButton.snp.bottom).offset(10)
            make.left.equalTo(smsButton.snp.right).offset(72)
            make.width.height.equalTo(20)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.left.equalTo(emailButton.snp.right).offset(10)
            make.centerY.equalTo(emailButton)
        }
        
        overFourteenYearButton.snp.makeConstraints { make in
            make.top.equalTo(smsButton.snp.bottom).offset(21)
            make.left.equalTo(termsAndConditionsContainerView).offset(20)
            make.width.height.equalTo(20)
        }
        
        overFourteenYearLabel.snp.makeConstraints { make in
            make.left.equalTo(overFourteenYearButton.snp.right).offset(10)
            make.centerY.equalTo(overFourteenYearButton)
        }
        
        phoneNumberContainerView.snp.makeConstraints { make in
            make.top.equalTo(termsAndConditionsContainerView.snp.bottom).offset(50)
            make.left.equalTo(scrollContentView).offset(20)
            make.right.equalTo(scrollContentView).offset(-20)
            make.height.equalTo(80)
        }
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.left.right.equalTo(phoneNumberContainerView)
            make.height.equalTo(60)
        }
        
        phoneNumberErrorLabel.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(phoneNumberContainerView)
            make.height.equalTo(15)
        }
        
        super.updateViewConstraints()
    }
}

extension SkyFloatingLabelTextField {
    class func createTextField(placeholder: String? = nil) -> SkyFloatingLabelTextField {
        let textField = SkyFloatingLabelTextField()
        
        textField.textColor = .black2
        textField.font = UIFont.spoqaHanSans(size: 20, style: .Regular)
        
        textField.lineHeight = 1
        textField.selectedLineHeight = 2
        textField.selectedLineColor = .mainColor
        
        guard let placeholder = placeholder else {
            return textField
        }
        
        textField.placeholder = placeholder
        textField.placeholderColor = .grey4
        textField.placeholderFont = UIFont.spoqaHanSans(size: 20)
        textField.title = placeholder
        textField.titleFont = UIFont.spoqaHanSans(size: 12, style: .Regular)
        textField.selectedTitleColor = .grey4
        
        return textField
    }
}
