//
//  CertificationNumberViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/02/17.
//

import PanModal
import RxSwift
import SkyFloatingLabelTextField
import UIKit

class CertificationNumberViewController: UIViewController {

    // MARK: Constants
    let titleLabel = UILabel().then {
        $0.text = "인증번호를 요청해주세요."
        $0.textColor = .grey4
        $0.font = UIFont.spoqaHanSans(size: 12, style: .Regular)
    }
    
    let receiveButton = UIButton().then {
        $0.setTitle("인증번호받기", for: .normal)
        $0.setTitleColor(.black2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 16)
        $0.backgroundColor = .mainColor
        $0.layer.cornerRadius = 7
    }
    
    let receiveTextFieldContainerView = UIView().then {
        $0.isHidden = true
    }
    
    let receiveTextField = SkyFloatingLabelTextField.createTextField(placeholder: "인증번호입력").then {
        $0.title = "인증번호를 입력해주세요."
    }
    
    let timeLabel = UILabel().then {
        $0.text = "03:00"
        $0.font = UIFont.spoqaHanSans(size: 12, style: .Regular)
        $0.textColor = .grey4
    }
    
    let repeatButton = UIButton().then {
        $0.setTitle("재요청", for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
        $0.setTitleColor(.black2, for: .normal)
        $0.layer.cornerRadius = 7
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.grey7.cgColor
    }
    
    let doneButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 16)
        $0.setTitleColor(.black2, for: .normal)
        $0.backgroundColor = .mainColor
    }
    
    // MARK: Variables
    var isKeyboardShow = false {
        didSet {
            titleLabel.isHidden = isKeyboardShow
            receiveButton.isHidden = isKeyboardShow
            
            receiveTextFieldContainerView.isHidden = !isKeyboardShow
            
            panModalSetNeedsLayoutUpdate()
            panModalTransition(to: .longForm)
        }
    }
    
    var viewHeight: CGFloat = 185
    
    var disposeBag = DisposeBag()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setKeyboardNotification()
        receiveButton.rx.tap
            .bind { [weak self] in
                self?.receiveTextField.becomeFirstResponder()
            }.disposed(by: disposeBag)
        
        repeatButton.rx.tap
            .bind { [weak self] in
                self?.receiveTextFieldContainerView.endEditing(true)
            }.disposed(by: disposeBag)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(receiveButton)
        
        view.addSubview(receiveTextFieldContainerView)
        receiveTextFieldContainerView.addSubview(receiveTextField)
        receiveTextFieldContainerView.addSubview(timeLabel)
        receiveTextFieldContainerView.addSubview(repeatButton)
        receiveTextFieldContainerView.addSubview(doneButton)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(22)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        receiveButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(7)
            make.centerX.equalTo(view)
            make.width.equalTo(view).offset(-40)
            make.height.equalTo(45)
        }
        
        receiveTextFieldContainerView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view)
            make.centerX.equalTo(view)
            make.height.equalTo(225)
        }
        
        receiveTextField.snp.makeConstraints { make in
            make.bottom.equalTo(repeatButton)
            make.left.equalTo(receiveTextFieldContainerView).offset(20)
            make.right.equalTo(repeatButton.snp.left).offset(-15)
            make.height.equalTo(50)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.right.equalTo(receiveTextField)
            make.centerY.equalTo(repeatButton)
        }
        
        repeatButton.snp.makeConstraints { make in
            make.top.equalTo(receiveTextFieldContainerView).offset(49)
            make.right.equalTo(receiveTextFieldContainerView).offset(-20)
            make.width.equalTo(68)
            make.height.equalTo(37)
        }
        
        doneButton.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(receiveTextFieldContainerView)
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
        
        viewHeight = 225 + keyboardFrame.height
        isKeyboardShow = true
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
        viewHeight = 185
        isKeyboardShow = false
    }
}

extension CertificationNumberViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        nil
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(viewHeight - self.view.safeAreaInsets.bottom)
    }
}
