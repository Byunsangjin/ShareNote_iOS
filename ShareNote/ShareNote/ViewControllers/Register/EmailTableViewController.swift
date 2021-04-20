//
//  EmailTableViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/03.
//

import PanModal
import RxCocoa
import RxSwift
import SkyFloatingLabelTextField
import Then
import UIKit

class EmailTableViewController: UIViewController {
    
    // MARK: Constants
    let tableView = UITableView().then {
        $0.separatorStyle = .none
    }
    
    let textFieldContainerView = UIView().then {
        $0.isHidden = true
    }
    
    let atLabel = UILabel().then {
        $0.text = "@"
        $0.textColor = .grey4
        $0.font = UIFont.spoqaHanSans(size: 20)
    }
    
    let emailTextField = SkyFloatingLabelTextField.createTextField(placeholder: "직접입력").then {
        $0.title = "이메일주소 직접입력"
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
    
    var height: CGFloat = 0
    
    // MARK: Methods
    override func viewDidLoad() {
        setUI()
        bindTableView()
        setKeyboardNotification()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        height = tableView.contentSize.height
        panModalSetNeedsLayoutUpdate()
        panModalTransition(to: .longForm)
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        view.addSubview(textFieldContainerView)
        textFieldContainerView.addSubview(atLabel)
        textFieldContainerView.addSubview(emailTextField)
        
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
        
        textFieldContainerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(60)
        }
        
        atLabel.snp.makeConstraints { make in
            make.left.equalTo(textFieldContainerView)
            make.bottom.equalTo(textFieldContainerView).offset(-5)
            make.width.equalTo(20)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.left.equalTo(atLabel.snp.right).offset(6)
            make.right.equalTo(textFieldContainerView)
            make.bottom.equalTo(textFieldContainerView)
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
        
        height = keyboardFrame.size.height + textFieldContainerView.frame.height + 25
        panModalSetNeedsLayoutUpdate()
        panModalTransition(to: .longForm)
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
        height = tableView.contentSize.height
        panModalSetNeedsLayoutUpdate()
        panModalTransition(to: .longForm)
    }
}

extension EmailTableViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(height)
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
        if indexPath.row == 0 {
            tableView.isHidden = true
            textFieldContainerView.isHidden = false
            emailTextField.becomeFirstResponder()
            return
        }
        
        dismiss(animated: true) { [weak self] in
            guard let email = self?.emailList[indexPath.row] else { return }
            self?.delegate?.didSelectEmail(email: email)
        }
    }
}
