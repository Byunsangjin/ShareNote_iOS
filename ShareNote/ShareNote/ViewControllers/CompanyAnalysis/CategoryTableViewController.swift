//
//  CategoryTableViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/14.
//

import PanModal
import UIKit

class CategoryTableViewController: UIViewController {

    // MARK: Constants
    let titleLabel = UILabel().then {
        $0.text = "카테고리 선택"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
    }
    
    let tableView = UITableView().then {
        $0.separatorStyle = .none
    }
    
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
        
        view.addSubview(titleLabel)
        
        view.addSubview(tableView)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(30)
            make.left.equalTo(view).offset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.bottom.equalTo(view)
        }
        
        super.updateViewConstraints()
    }
}

extension CategoryTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        
        var title = "반도체"
        if indexPath.row == 0 {
             title = "전체"
        } else if indexPath.row == 1{
            title = "바이오"
        }
        cell.textLabel?.text = title
        cell.selectionStyle = .gray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 59
    }
}

extension CategoryTableViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        nil
    }
}
