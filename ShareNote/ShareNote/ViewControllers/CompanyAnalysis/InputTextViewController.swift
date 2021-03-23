//
//  InputTextViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/22.
//

import RxSwift
import SnapKit
import UIKit

class InputTextViewController: UIViewController {

    // MARK: Constants
    let naviTitleLabel = UILabel().then {
        $0.text = "기업분석 작성"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 16)
    }
    
    let closeButton = UIButton().then {
        $0.setImage(UIImage(named: "icClose"), for: .normal)
    }
    
    let titleContainerView = UIView().then {
        $0.backgroundColor = .grey7
        $0.layer.applySketchShadow(color: .black1, alpha: 0.05, x: 0, y: 1, blur: 10, spread: 0)
        $0.layer.cornerRadius = 7
    }
    
    let titleLabel = UILabel().then {
        $0.text = "경쟁사는 어떤 기업인가요?"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Bold)
    }
    
    let textView = UITextView().then {
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
        $0.textColor = .black2
    }
    
    let saveButton = UIButton().then {
        $0.setTitle("저장", for: .normal)
        $0.setTitleColor(.black2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 16)
        $0.backgroundColor = .mainColor
        $0.layer.cornerRadius = 7
    }
    
    let keyboardContainerView = UIView().then {
        $0.backgroundColor = .whiteTwo
        $0.isHidden = true
    }
    
    let trashButton = UIButton().then {
        $0.setImage(UIImage(named: "icMainTrash"), for: .normal)
    }
    
    let keyboardHideButton = UIButton().then {
        $0.setImage(UIImage(named: "icKeyboard"), for: .normal)
    }
    
    // MARK: Variables
    var keyboardContainerViewBottom: Constraint?
    
    var disposeBag = DisposeBag()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setKeyboardNotification()
        
        keyboardHideButton.rx.tap
            .bind { [weak self] in
                self?.textView.endEditing(true)
            }.disposed(by: disposeBag)
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(naviTitleLabel)
        view.addSubview(closeButton)
        
        view.addSubview(titleContainerView)
        view.addSubview(titleLabel)
        
        view.addSubview(textView)
        
        view.addSubview(saveButton)
        
        view.addSubview(keyboardContainerView)
        keyboardContainerView.addSubview(trashButton)
        keyboardContainerView.addSubview(keyboardHideButton)
        
        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        naviTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(38)
            make.centerX.equalTo(view)
        }
        
        closeButton.snp.makeConstraints { make in
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.centerY.equalTo(naviTitleLabel)
            make.width.height.equalTo(30)
        }
        
        titleContainerView.snp.makeConstraints { make in
            make.top.equalTo(naviTitleLabel.snp.bottom).offset(25)
            make.centerX.equalTo(view)
            make.width.equalTo(view).offset(-40)
            make.height.equalTo(55)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleContainerView).offset(15)
            make.right.equalTo(titleContainerView).offset(-15)
            make.centerY.equalTo(titleContainerView)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(titleContainerView.snp.bottom).offset(20)
            make.bottom.equalTo(saveButton.snp.top).offset(-20)
            make.centerX.equalTo(titleContainerView)
            make.width.equalTo(titleContainerView)
        }
        
        saveButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-7)
            make.width.equalTo(textView)
            make.height.equalTo(45)
        }
        
        keyboardContainerView.snp.makeConstraints { make in
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            keyboardContainerViewBottom = make.bottom.equalTo(view).constraint
            make.height.equalTo(40)
        }
        
        trashButton.snp.makeConstraints { make in
            make.left.equalTo(keyboardContainerView).offset(15)
            make.centerY.equalTo(keyboardContainerView)
            make.width.height.equalTo(30)
        }
        
        keyboardHideButton.snp.makeConstraints { make in
            make.right.equalTo(keyboardContainerView).offset(-15)
            make.centerY.equalTo(keyboardContainerView)
            make.width.height.equalTo(30)
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
        
        self.keyboardContainerView.isHidden = false
        self.keyboardContainerViewBottom?.update(offset: -keyboardFrame.size.height)
        self.keyboardContainerView.updateConstraints()

        UIView.animate(withDuration: 1, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
        keyboardContainerView.isHidden = true
        keyboardContainerViewBottom?.update(offset: 0)
    }
}
