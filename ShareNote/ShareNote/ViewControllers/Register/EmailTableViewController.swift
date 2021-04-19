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
    
    var emailList = Observable.of(["직적입력",
                                   "naver.com",
                                   "gmail.com",
                                   "daum.net",
                                   "nate.com",
                                   "hanmail.com",
                                   "kakao.com"])
    
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
        tableView.register(EmailTableViewCell.self, forCellReuseIdentifier: "EmailTableViewCell")
        
        emailList.bind(to: tableView.rx.items) { (tableView: UITableView, index: Int, element: String) in
            let cell = UITableViewCell()
            cell.textLabel?.text = element
            return cell
        }.disposed(by: disposeBag)

        tableView.rx.modelSelected(String.self)
            .subscribe(onNext: { [weak self] email in
                self?.dismiss(animated: true) {
                    logger.verbose(email)
                    self?.delegate?.didSelectEmail(email: email)
                }
            })
            .disposed(by: disposeBag)
        
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
