//
//  PopupViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/02/21.
//

import UIKit

class PopupViewController: UIViewController {

    let containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 7
    }
    
    let titleLabel = UILabel().then {
        $0.text = "휴대폰번호 혹은 생년월일이 맞나요?"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 16, style: .Regular)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    let messageLabel = UILabel().then {
        $0.text = "정보를 다시 확인해주세요."
        $0.textColor = .grey4
        $0.font = UIFont.spoqaHanSans(size: 12, style: .Regular)
        $0.textAlignment = .center
    }
    
    let button = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.black2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
        $0.backgroundColor = .mainColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(button)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view)
            make.width.equalTo(view).offset(-80)
            make.height.equalTo(containerView.snp.width).multipliedBy(204.0 / 295.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(51)
            make.centerX.equalTo(containerView)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.centerX.equalTo(containerView)
        }
        
        button.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(containerView)
            make.height.equalTo(45)
        }
        
        super.updateViewConstraints()
    }
}
