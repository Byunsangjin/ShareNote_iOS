//
//  EmailTableViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/03.
//

import PanModal
import RxCocoa
import RxSwift
import Then
import UIKit

class EmailTableViewController: UIViewController {
    
    // MARK: Constants
    let tableView = UITableView().then {
        $0.separatorStyle = .none
    }
    
    // MARK: Variables
    var disposeBag = DisposeBag()
    
    var emailList = ["직적입력",
                     "naver.com",
                     "gmail.com",
                     "daum.net",
                     "nate.com",
                     "hanmail.com",
                     "kakao.com"]
    
    var delegate: RegisterDelegate?
    
    // MARK: Methods
    override func viewDidLoad() {
        self.view.backgroundColor = .red
        
        setUI()
        bindTableView()
    }
    
    func setUI() {
        view.addSubview(tableView)
        
        view.setNeedsUpdateConstraints()
    }
    
    func bindTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 59
    }
    
    @objc
    func checkBtnTouched() {
        logger.verbose("checkBtnTouched")
    }
    
    override func updateViewConstraints() {
        tableView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.width.height.equalTo(view)
        }
        
        super.updateViewConstraints()
    }
}

extension EmailTableViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(self.view.frame.height / 2)
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
}

extension EmailTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = emailList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) { [weak self] in
            guard let email = self?.emailList[indexPath.row] else { return }
            self?.delegate?.didSelectEmail(email: email)
        }
    }
}
