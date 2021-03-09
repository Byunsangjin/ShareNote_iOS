//
//  LockModeSettingViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/09.
//

import RxSwift
import UIKit

class LockModeSettingViewController: UIViewController {

    // MARK: Constants
    let navigationView = NavigationView().then {
        $0.titleLabel.text = "잠금설정"
    }
    
    let lockEnableLabel = UILabel().then {
        $0.text = "화면 잠금 사용"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
    }
    
    let lockEnableSwitch = UISwitch().then {
        $0.onTintColor = .mainColor
    }
    
    let lockEnableDescriptionLabel = UILabel().then {
        $0.text = "화면 잠금시\n간편비밀번호를 사용합니다."
        $0.textColor = .grey4
        $0.font = UIFont.spoqaHanSans(size: 12, style: .Regular)
        $0.numberOfLines = 0
    }

    let tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.isScrollEnabled = false
    }
    
    // MARK: Variables
    var disposeBag = DisposeBag()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MoveDetailTableViewCell.self, forCellReuseIdentifier: "MoveDetailTableViewCell")
        
        lockEnableSwitch.rx.controlEvent(.valueChanged)
            .bind { [weak self] in
                self?.tableView.reloadData()
            }.disposed(by: disposeBag)
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(navigationView)
        
        view.addSubview(lockEnableLabel)
        view.addSubview(lockEnableSwitch)
        view.addSubview(lockEnableDescriptionLabel)
        
        view.addSubview(tableView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
        
        lockEnableLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(19)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        lockEnableSwitch.snp.makeConstraints { make in
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.centerY.equalTo(lockEnableLabel)
        }
        
        lockEnableDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(lockEnableLabel.snp.bottom).offset(19)
            make.left.equalTo(lockEnableLabel)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(lockEnableDescriptionLabel.snp.bottom).offset(25)
            make.width.equalTo(view)
            make.height.equalTo(110)
        }
        
        super.updateViewConstraints()
    }
}

extension LockModeSettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoveDetailTableViewCell") as? MoveDetailTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.isEnabled = lockEnableSwitch.isOn
                
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "간편비밀번호 변경"
        case 1:
            cell.titleLabel.text = "생체인증 사용"
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if lockEnableSwitch.isOn == false {
            return
        }
        
        switch indexPath.row {
        case 0:
            logger.verbose("간편비밀번호 변경")
        case 1:
            logger.verbose("생체인증 사용")
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
