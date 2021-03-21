//
//  QuestionConfirmViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/17.
//

import UIKit
import SnapKit

class QuestionConfirmViewController: UIViewController {

    // MARK: Constants
    let navigationView = NavigationView().then {
        $0.titleLabel.text = "질문 확인하기"
    }
    
    let titleView = UIView.createTradingShareCellView().then {
        $0.backgroundColor = .grey6
    }
    
    let titleLabel = UILabel().then {
        $0.text = "선택한 질문 갯수"
        $0.textColor = .grey3
        $0.font = UIFont.spoqaHanSans(size: 12)
    }
    
    let selectedQuestionCountLabel = UILabel().then {
        $0.text = "4개"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 12)
    }
    
    let selectedQuestionTableView = UITableView().then {
        $0.separatorStyle = .none
    }
    
    let directInputContainerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 7
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.mainColor.cgColor
        $0.layer.applySketchShadow(color: .black1, alpha: 0.05, x: 0, y: 1, blur: 10, spread: 0)
    }
    
    let addDirectInputView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let directInputLabel = UILabel().then {
        $0.text = "직접입력"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Bold)
    }
    
    let addDirectInputImageView = UIImageView().then {
        $0.image = UIImage(named: "icPlus")
    }
    
    let directInputTextField = UITextField().then {
        $0.placeholder = "질문을 입력해 주세요."
        
        
        $0.attributedPlaceholder = NSAttributedString(string: "질문을 입력해 주세요.",
                                                      attributes: [.font : UIFont.spoqaHanSans(size: 14, style: .Bold),
                                                                   .foregroundColor : UIColor.grey4])
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Bold)
        $0.textColor = .black2
        $0.isHidden = true
    }
    
    let inputCompleteButton = UIButton().then {
        $0.setTitle("입력완료", for: .normal)
        $0.setTitleColor(.black2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 16)
        $0.backgroundColor = .mainColor
        $0.isHidden = true
    }
    
    let okButton = UIButton().then {
        $0.setTitle("질문 작성하기", for: .normal)
        $0.setTitleColor(.black2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 16)
        
        $0.backgroundColor = .mainColor
        $0.layer.cornerRadius = 7
    }
    
    // MARK: Variables
    var height: Constraint?
    
    var inputCompleteBottom: Constraint?
    
    var count = 3
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        selectedQuestionTableView.delegate = self
        selectedQuestionTableView.dataSource = self
        
        selectedQuestionTableView.register(QuestionConfirmTableViewCell.self, forCellReuseIdentifier: "QuestionConfirmTableViewCell")
        
        addDirectInputView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(directBtnTouched)))
        
        setKeyboardNotification()
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(navigationView)
        
        view.addSubview(titleView)
        titleView.addSubview(titleLabel)
        titleView.addSubview(selectedQuestionCountLabel)
        
        view.addSubview(selectedQuestionTableView)
        
        view.addSubview(directInputContainerView)
        directInputContainerView.addSubview(addDirectInputView)
        addDirectInputView.addSubview(directInputLabel)
        addDirectInputView.addSubview(addDirectInputImageView)
        directInputContainerView.addSubview(directInputTextField)
        
        view.addSubview(inputCompleteButton)
        
        view.addSubview(okButton)
        
        view.setNeedsUpdateConstraints()
    }

    override func updateViewConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(16)
            make.centerX.equalTo(view)
            make.width.equalTo(view).offset(-40)
            make.height.equalTo(37)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(titleView).multipliedBy(0.85)
            make.centerY.equalTo(titleView)
        }
        
        selectedQuestionCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleView)
            make.left.equalTo(titleLabel.snp.right).offset(19)
        }
        
        selectedQuestionTableView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(12)
            make.centerX.equalTo(view)
            make.width.equalTo(view.safeAreaLayoutGuide)
            height = make.height.equalTo(195).priority(.medium).constraint
            make.bottom.lessThanOrEqualTo(okButton.snp.top).offset(-115).priority(.high)
        }
        
        directInputContainerView.snp.makeConstraints { make in
            make.top.equalTo(selectedQuestionTableView.snp.bottom).offset(30)
            make.centerX.equalTo(view)
            make.width.equalTo(titleView)
            make.height.equalTo(55)
        }
        
        addDirectInputView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(directInputContainerView)
        }
        
        directInputLabel.snp.makeConstraints { make in
            make.left.equalTo(addDirectInputView).offset(15)
            make.centerY.equalTo(addDirectInputView)
        }
        
        addDirectInputImageView.snp.makeConstraints { make in
            make.right.equalTo(addDirectInputView).offset(-13)
            make.centerY.equalTo(addDirectInputView)
            make.width.height.equalTo(30)
        }
        
        directInputTextField.snp.makeConstraints { make in
            make.left.right.equalTo(directInputContainerView).offset(20)
            make.centerY.equalTo(directInputContainerView)
        }
        
        inputCompleteButton.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            inputCompleteBottom = make.bottom.equalTo(view).constraint
            make.height.equalTo(45)
        }
        
        okButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-37)
            make.centerX.equalTo(view)
            make.width.equalTo(titleView)
            make.height.equalTo(45)
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
        
        self.inputCompleteButton.isHidden = false
        self.inputCompleteBottom?.update(offset: -keyboardFrame.size.height)
        self.inputCompleteButton.updateConstraints()

        UIView.animate(withDuration: 1, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
        inputCompleteButton.isHidden = true
        inputCompleteBottom?.update(offset: 0)
    }
    
    @objc
    func directBtnTouched() {
        addDirectInputView.isHidden = true
        directInputTextField.isHidden = false
        directInputTextField.becomeFirstResponder()
    }
}

extension QuestionConfirmViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionConfirmTableViewCell") as? QuestionConfirmTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        count += 1
        tableView.insertRows(at: [IndexPath(row: indexPath.row + 1, section: 0)], with: .top)
        
        let height = tableView.contentSize.height / 44 * 65
        self.height?.update(offset: height)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
