//
//  TermsAndPersonalInfoProcessingViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/10.
//

import UIKit

class TermsAndPersonalInfoProcessingViewController: UIViewController {

    // MARK: Constants
    let navigationView = NavigationView().then {
        $0.titleLabel.text = "약관 및 개인정보처리"
    }

    let tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.isScrollEnabled = false
    }
    
    let cellTitleList = ["서비스 이용약관",
                         "개인정보 수집 이용동의",
                         "개인정보 처리방침"];
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
            make.height.equalTo(165)
        }
        
        super.updateViewConstraints()
    }
}

extension TermsAndPersonalInfoProcessingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoreMenuTableViewCell") as? MoreMenuTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = cellTitleList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        logger.verbose(cellTitleList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
