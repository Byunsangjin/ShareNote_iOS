//
//  QuestionConfirmViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/17.
//

import UIKit

class QuestionConfirmViewController: UIViewController {

    // MARK: Constants
    let navigationView = NavigationView().then {
        $0.titleLabel.text = "질문 확인하기"
    }
    
    let titleView = UIView.createTradingShareCellView().then {
        $0.backgroundColor = .grey6
    }
    
    let titleLabel = UILabel().then {
        $0.text = "선택한 질문 갯수"
        $0.textColor = .grey3
        $0.font = UIFont.spoqaHanSans(size: 12)
    }
    
    let selectedQuestionCountLabel = UILabel().then {
        $0.text = "4개"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 12)
    }
    
    let selectedQuestionTableView = UITableView()
    
    let createQuestionButton = UIButton()
    
    let okButton = UIButton()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(navigationView)
        
        view.addSubview(titleView)
        titleView.addSubview(titleLabel)
        titleView.addSubview(selectedQuestionCountLabel)
        
        view.setNeedsUpdateConstraints()
    }

    override func updateViewConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(16)
            make.centerX.equalTo(view)
            make.width.equalTo(view).offset(-40)
            make.height.equalTo(37)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(titleView).multipliedBy(0.85)
            make.centerY.equalTo(titleView)
        }
        
        selectedQuestionCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleView)
            make.left.equalTo(titleLabel.snp.right).offset(19)
        }
        
        super.updateViewConstraints()
    }
}
