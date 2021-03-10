//
//  UserInfoViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/10.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    // MARK: Constants
    let navigationView = NavigationView().then {
        $0.titleLabel.text = "김쉐어님의 정보"
    }

    let tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.isScrollEnabled = false
    }
    
    let modifyButton = UIButton().then {
        $0.setTitle("수정", for: .normal)
        $0.setTitleColor(.black2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 14)
    }
    
    let cellTitleList = ["이름",
                         "생년월일",
                         "핸드폰번호"];
    
    let cellDetailList = ["김쉐어",
                          "98.08.08",
                          "010-22**-21**"]
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(navigationView)
        navigationView.addSubview(modifyButton)
        
        view.addSubview(tableView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
        
        modifyButton.snp.makeConstraints { make in
            make.right.equalTo(navigationView).offset(-20)
            make.centerY.equalTo(navigationView)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.centerX.width.equalTo(view)
            make.height.equalTo(165)
        }
        
        super.updateViewConstraints()
    }
}

extension UserInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        cell.textLabel?.text = cellTitleList[indexPath.row]
        cell.textLabel?.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
        cell.detailTextLabel?.text = cellDetailList[indexPath.row]
        cell.detailTextLabel?.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        logger.verbose(cellTitleList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
