//
//  CompleteTradingLogViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/02/11.
//

import UIKit

class CompleteTradingLogViewController: UIViewController {
    
    // Navigation ContainerView
    let navigationContainerView = UIView().then {
        $0.backgroundColor = UIColor(red: 1, green: 214/255, blue: 8/255, alpha: 1)
    }
    
    let navigationTitleLabel = UILabel().then {
        $0.text = "매매일지 작성"
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    let backButton = UIButton().then {
        $0.setImage(UIImage(named: "icBack"), for: .normal)
    }
    
    let editButton = UIButton().then {
        $0.setTitle("편집", for: .normal)
        $0.setTitleColor(UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    // TradingLogTitle ContainerView
    let tradingLogTitleContainerView = UIView().then {
        $0.backgroundColor = UIColor(red: 1, green: 214/255, blue: 8/255, alpha: 1)
    }
    
    let dateLabel = UILabel().then {
        $0.text = "2021년 1월 7일 오후 7:43"
        $0.textColor = UIColor(red: 111/255, green: 93/255, blue: 0, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    let titleLabel = UILabel().then {
        $0.text = "기아차 가즈아~~"
        $0.textColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        $0.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(navigationContainerView)
        navigationContainerView.addSubview(navigationTitleLabel)
        navigationContainerView.addSubview(backButton)
        navigationContainerView.addSubview(editButton)
        
        view.addSubview(tradingLogTitleContainerView)
        tradingLogTitleContainerView.addSubview(dateLabel)
        tradingLogTitleContainerView.addSubview(titleLabel)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        navigationContainerView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
        
        navigationTitleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(navigationContainerView)
        }
        
        backButton.snp.makeConstraints { make in
            make.left.equalTo(navigationContainerView.safeAreaLayoutGuide).offset(15)
            make.centerY.equalTo(navigationContainerView)
            make.width.height.equalTo(30)
        }
        
        editButton.snp.makeConstraints { make in
            make.right.equalTo(navigationContainerView.safeAreaLayoutGuide).offset(-20)
            make.centerY.equalTo(navigationContainerView)
        }
        
        tradingLogTitleContainerView.snp.makeConstraints { make in
            make.top.equalTo(navigationContainerView.snp.bottom)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(135)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(tradingLogTitleContainerView.snp.top).offset(34)
            make.left.equalTo(tradingLogTitleContainerView).offset(20)
            make.right.equalTo(tradingLogTitleContainerView).offset(-20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(15)
            make.left.equalTo(tradingLogTitleContainerView).offset(20)
            make.right.equalTo(tradingLogTitleContainerView).offset(-20)
        }
        
        super.updateViewConstraints()
    }
}
