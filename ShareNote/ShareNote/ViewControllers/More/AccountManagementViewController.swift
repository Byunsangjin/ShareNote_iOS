//
//  AccountManagementViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/10.
//

import UIKit

class AccountManagementViewController: UIViewController {

    // MARK: Constants
    let navigationView = NavigationView().then {
        $0.titleLabel.text = "계정 관리"
    }

    let tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.isScrollEnabled = false
    }
    
    let cellTitleList = ["이메일",
                         "아이디",
                         "비밀번호",
                         "탈퇴하기"];
    
    let cellDetailList = ["sharenotie@naver.com",
                          "iamsharenote",
                          "비밀번호변경",
                          nil]
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(MoreMenuTableViewCell.self, forCellReuseIdentifier: "MoreMenuTableViewCell")
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(navigationView)
        
        view.addSubview(tableView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.centerX.width.equalTo(view)
            make.height.equalTo(220)
        }
        
        super.updateViewConstraints()
    }
}

extension AccountManagementViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0...1:
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
            cell.textLabel?.text = cellTitleList[indexPath.row]
            cell.textLabel?.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
            cell.detailTextLabel?.text = cellDetailList[indexPath.row]
            cell.detailTextLabel?.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
            
            return cell
        case 2...3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoreMenuTableViewCell") as? MoreMenuTableViewCell else {
                return UITableViewCell()
            }
            
            cell.titleLabel.text = cellTitleList[indexPath.row]
            cell.descriptionLabel.text = cellDetailList[indexPath.row]
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        logger.verbose(cellTitleList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
