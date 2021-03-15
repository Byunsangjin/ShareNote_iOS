//
//  CompanySearchViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/14.
//

import RxSwift
import SnapKit
import UIKit

class CompanySearchViewController: UIViewController {

    // MARK: Constants
    let navigationView = NavigationView().then {
        $0.titleLabel.text = "기업 선택하기"
    }
    
    let searchTextField = UITextField().then {
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
        $0.textColor = .black2
        
        $0.borderStyle = .roundedRect
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.mainColor.cgColor
        $0.layer.cornerRadius = 7
        $0.placeholder = "분석하고 싶은 기업을 검색하세요."
        
        $0.leftViewMode = .always
        let leftView = UIView(frame: CGRect(x: 10, y: 0, width: 35, height: 30))
        let imageView  = UIImageView(frame: CGRect(x: 10, y: 0, width: 30, height: 30))
        imageView.image = UIImage(named:"icSearch")
        leftView.addSubview(imageView)
        
        $0.leftView = leftView
    }
    
    // Empty View
    let emptyContainerView = UIView().then {
        $0.isHidden = true
    }
    
    let emptyImageView = UIImageView().then {
        $0.image = UIImage(named: "illustSearch1")
    }
    
    let emptyLabel = UILabel().then {
        $0.text = "관심있는 기업을 검색하고\n다양한 관점에서 분석을 시작하세요"
        $0.textColor = .grey1
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    // No Search View
    let noSearchContainerView = UIView().then {
        $0.isHidden = true
    }
    
    let noSearchImageView = UIImageView().then {
        $0.image = UIImage(named: "illustNotSearch")
    }
    
    let noSearchTitleLabel = UILabel().then {
        $0.text = "아쉽게도 검색 결과가 없습니다"
        $0.textColor = .grey1
        $0.font = UIFont.spoqaHanSans(size: 16)
        $0.textAlignment = .center
    }
    
    let noSearchDescriptionLabel = UILabel().then {
        $0.text = "주식명이나 종목코드를\n다시 확인해주세요"
        $0.textColor = .grey3
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    // Search Table View
    let searchTableContainerView = UIView()
    
    let searchResultLabel = UILabel().then {
        $0.text = "총 2건의 검색결과가 있습니다"
        $0.textColor = .grey4
        $0.font = UIFont.spoqaHanSans(size: 12, style: .Regular)
    }
    
    let searchTableView = UITableView().then {
        $0.separatorStyle = .singleLine
    }
    
    let cancelButtonView = UIView().then {
        $0.backgroundColor = .whiteTwo
        $0.isHidden = true
    }
    
    let cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.grey2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
    }
    
    // MARK: Variables
    var cancelButtonViewBottomConstraint: Constraint?
    
    var disposeBag = DisposeBag()
    
    // MARK: Variables
    var stockList = ["삼성전자 005930", "삼성전자우 000321", "랩지노믹스 123456", "가짜삼성주식 0123945"]
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setKeyboardNotification()
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        cancelButton.rx.tap
            .bind { [weak self] in
                self?.searchTextField.endEditing(true)
            }.disposed(by: disposeBag)
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(navigationView)
        
        view.addSubview(searchTextField)
        
        view.addSubview(emptyContainerView)
        emptyContainerView.addSubview(emptyImageView)
        emptyContainerView.addSubview(emptyLabel)
        
        view.addSubview(noSearchContainerView)
        noSearchContainerView.addSubview(noSearchImageView)
        noSearchContainerView.addSubview(noSearchTitleLabel)
        noSearchContainerView.addSubview(noSearchDescriptionLabel)
        
        view.addSubview(searchTableContainerView)
        searchTableContainerView.addSubview(searchResultLabel)
        searchTableContainerView.addSubview(searchTableView)
        
        view.addSubview(cancelButtonView)
        cancelButtonView.addSubview(cancelButton)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(25)
            make.centerX.equalTo(view)
            make.width.equalTo(view).offset(-40)
            make.height.equalTo(45)
        }
        
        // Empty View
        emptyContainerView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        emptyImageView.snp.makeConstraints { make in
            make.top.equalTo(emptyContainerView).offset(108)
            make.centerX.equalTo(emptyContainerView)
            make.width.equalTo(80.5)
            make.height.equalTo(79.4)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom).offset(32.7)
            make.centerX.equalTo(emptyContainerView)
        }

        // No Search View
        noSearchContainerView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        noSearchImageView.snp.makeConstraints { make in
            make.top.equalTo(emptyContainerView).offset(108)
            make.centerX.equalTo(emptyContainerView)
            make.width.equalTo(80.5)
            make.height.equalTo(79.4)
        }
        
        noSearchTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom).offset(32.7)
            make.centerX.equalTo(emptyContainerView)
        }
        
        noSearchDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(noSearchTitleLabel.snp.bottom).offset(9)
            make.centerX.equalTo(emptyContainerView)
        }
        
        // Search Table View
        searchTableContainerView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        searchResultLabel.snp.makeConstraints { make in
            make.top.equalTo(searchTableContainerView).offset(20)
            make.left.equalTo(searchTextField)
        }
        
        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(searchResultLabel.snp.bottom).offset(5)
            make.left.right.bottom.equalTo(searchTableContainerView)
        }
        
        // Cancel Button View
        cancelButtonView.snp.makeConstraints { make in
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            cancelButtonViewBottomConstraint = make.bottom.equalTo(view).constraint
            make.height.equalTo(45)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.right.equalTo(cancelButtonView).offset(-21)
            make.centerY.equalTo(cancelButtonView)
        }
        
        super.updateViewConstraints()
    }
    
    func setKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        self.cancelButtonView.isHidden = false
        
        self.cancelButtonViewBottomConstraint?.update(offset: -keyboardFrame.size.height)
        
        UIView.animate(withDuration: 1, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
        cancelButtonView.isHidden = true
        self.cancelButtonViewBottomConstraint?.update(inset: 0)
    }
}

extension CompanySearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockList.filter { $0.contains("삼성") }.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let title = stockList.filter { $0.contains("삼성") }[indexPath.row]
        
        let range = (title as NSString).range(of: "삼성")
        let attributeString = containTextChangeColor(title, range: range)
        cell.textLabel?.attributedText = attributeString
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func containTextChangeColor(_ text: String, range: NSRange) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.foregroundColor, value: UIColor.mainColor, range: range)
        return attributedString
    }
}
