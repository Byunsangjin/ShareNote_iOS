//
//  WriteCompanyAnalysisViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/21.
//

import UIKit

class WriteCompanyAnalysisViewController: UIViewController {

    // MARK: Constants
    let navigationView = NavigationView().then {
        $0.titleLabel.text = "기업분석 작성"
        
        $0.leftBarButton.setImage(nil, for: .normal)
        $0.leftBarButton.setTitle("취소", for: .normal)
        $0.rightBarButton.setTitle("저장", for: .normal)
    }
    
    let contentStackView = UIStackView().then {
        $0.axis = .vertical
    }
    
    // Stock, Title, Tag ContainerView
    let stockContainerView = UIView()
    
    let stockTitleLabel = UILabel().then {
        $0.text = "종목"
        $0.textColor = .grey3
        $0.font = UIFont.spoqaHanSans(size: 14)
    }
    
    let stockNameLabel = UILabel().then {
        $0.text = "삼성전자 005930"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 14)
    }
    
    let titleContainerView = UIView()
    
    let titleLabel = UILabel().then {
        $0.text = "제목"
        $0.textColor = UIColor.grey3
        $0.font = UIFont.spoqaHanSans(size: 14)
    }
    
    let titleTextField = UITextField().then {
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
        $0.borderStyle = .none
        $0.placeholder = "제목을 입력해주세요"
    }
    
    let tagInputContainerView = UIView()
    
    let tagInputTitleLabel = UILabel().then {
        $0.text = "태그"
        $0.textColor = UIColor.grey3
        $0.font = UIFont.spoqaHanSans(size: 14)
    }
    
    let tagContainerView = UIView()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(navigationView)
        
        view.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(stockContainerView)
        stockContainerView.addSubview(stockTitleLabel)
        stockContainerView.addSubview(stockNameLabel)
        
        contentStackView.addArrangedSubview(titleContainerView)
        titleContainerView.addSubview(titleLabel)
        titleContainerView.addSubview(titleTextField)
        
        contentStackView.addArrangedSubview(tagInputContainerView)
        tagInputContainerView.addSubview(tagInputTitleLabel)
        
        contentStackView.addArrangedSubview(tagContainerView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(34)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(194)
        }
        
        stockContainerView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        stockTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(stockContainerView).offset(20)
            make.centerY.equalTo(stockContainerView)
        }
        
        stockNameLabel.snp.makeConstraints { make in
            make.left.equalTo(stockTitleLabel).offset(60)
            make.centerY.equalTo(stockContainerView)
        }
        
        titleContainerView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleContainerView).offset(20)
            make.centerY.equalTo(titleContainerView)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.left.equalTo(titleLabel).offset(60)
            make.right.equalTo(titleContainerView).offset(-20)
            make.centerY.equalTo(titleContainerView)
        }
        
        tagInputContainerView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        tagInputTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(tagInputContainerView).offset(20)
            make.centerY.equalTo(tagInputContainerView)
        }
        
        tagContainerView.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        super.updateViewConstraints()
    }
}
