//
//  EmailTableViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/03.
//

import PanModal
import RxCocoa
import RxSwift
import SwiftyBeaver
import Then
import UIKit

class EmailTableViewController: UIViewController {
    
    // MARK: Constants
    let tableView = UITableView().then {
        $0.separatorStyle = .none
    }
    
    // MARK: Variables
    var disposeBag = DisposeBag()
    
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
        
        let cities = Observable.of(["Lisbon", "Copenhagen", "London", "Madrid", "Vienna"])

        cities.bind(to: tableView.rx.items) { [self] (tableView: UITableView, index: Int, element: String) in
            let cell = EmailTableViewCell(style: .default, reuseIdentifier: "EmailTableViewCell")
            cell.emailLabel.text = element
            cell.checkButton.addTarget(self, action: #selector(checkBtnTouched), for: .touchUpInside)
            return cell
        }.disposed(by: disposeBag)

        tableView.rx.modelSelected(String.self)
            .subscribe(onNext: { model in
                SwiftyBeaver.verbose("\(model) was selected")
            })
            .disposed(by: disposeBag)
    }
    
    @objc
    func checkBtnTouched() {
        SwiftyBeaver.verbose("checkBtnTouched")
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
