//
//  ChangeMyInfoViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/08.
//

import UIKit

class ChangeMyInfoViewController: UIViewController {

    // MARK: Constants
    static let labelTextColor = UIColor.black1
    static let labelFont = UIFont.spoqaHanSans(size: 14, style: .Regular)
    
    let navigationView = NavigationView().then {
        $0.titleLabel.text = "내 정보 수정"
    }
    
    let nameLabel = UILabel.createLabel(font: labelFont, textColor: labelTextColor).then {
        $0.text = "이름"
    }
    
    let nameTextField = UITextField.createTextField()
    
    let birthDateLabel = UILabel.createLabel(font: labelFont, textColor: labelTextColor).then {
        $0.text = "생년월일"
    }
    
    let birthDateTextField = UITextField.createTextField()
    
    let phoneNumberLabel = UILabel.createLabel(font: labelFont, textColor: labelTextColor).then {
        $0.text = "핸드폰번호"
    }
    
    let phoneNumberTextField = UITextField.createTextField()
    
    let okButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.black2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 16)
        $0.backgroundColor = .mainColor
        $0.layer.cornerRadius = 7
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(navigationView)
        
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(birthDateLabel)
        view.addSubview(birthDateTextField)
        view.addSubview(phoneNumberLabel)
        view.addSubview(phoneNumberTextField)
        
        view.addSubview(okButton)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(36)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.left.right.equalTo(nameLabel)
            make.height.equalTo(35)
        }
        
        birthDateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(40)
            make.left.right.equalTo(nameLabel)
        }
        
        birthDateTextField.snp.makeConstraints { make in
            make.top.equalTo(birthDateLabel.snp.bottom).offset(10)
            make.left.right.equalTo(nameLabel)
            make.height.equalTo(35)
        }
        
        phoneNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(birthDateTextField.snp.bottom).offset(40)
            make.left.right.equalTo(nameLabel)
        }
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberLabel.snp.bottom).offset(10)
            make.left.right.equalTo(nameLabel)
            make.height.equalTo(35)
        }
        
        okButton.snp.makeConstraints { make in
            make.left.right.equalTo(nameLabel)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-7)
            make.height.equalTo(45)
        }
        
        super.updateViewConstraints()
    }
}
