//
//  AlarmSettingViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/09.
//

import UIKit

class AlarmSettingViewController: UIViewController {
    
    // MARK: Constants
    let navigationView = NavigationView().then {
        $0.titleLabel.text = "알림설정"
    }
    
    let alarmLabel = UILabel().then {
        $0.text = "마케팅 / 혜택 알림"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
    }
    
    let alarmEnableSwitch = UISwitch().then {
        $0.onTintColor = .mainColor
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(navigationView)
        
        view.addSubview(alarmLabel)
        view.addSubview(alarmEnableSwitch)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
        
        alarmLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(19)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        alarmEnableSwitch.snp.makeConstraints { make in
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.centerY.equalTo(alarmLabel)
        }
        
        super.updateViewConstraints()
    }
}
