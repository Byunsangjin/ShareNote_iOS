//
//  AuthenticationViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/02/12.
//

import UIKit

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
        $0.backgroundColor = .green
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
            make.top.left.bottom.equalTo(scrollView)
            make.width.equalTo(view.safeAreaLayoutGuide)
        }
        
        super.updateViewConstraints()
    }
}
