//
//  CustomAlertViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/07.
//

import SnapKit
import UIKit

class CustomAlertViewController: UIViewController {

    // MARK: Constants
    let containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 7
        $0.clipsToBounds = true
    }
    
    let titleLabel = UILabel().then {
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    let messageLabel = UILabel().then {
        $0.textColor = .grey4
        $0.font = UIFont.spoqaHanSans(size: 12, style: .Regular)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    let firstActionButton = UIButton().then {
        $0.setTitleColor(.black2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
        $0.backgroundColor = .mainColor
    }
    
    let secondActionButton = UIButton().then {
        $0.setTitleColor(.black2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
        $0.backgroundColor = .grey7
    }
    
    // MARK: Variables
    var isExistSecondActionButton = false
    
    // MARK: Methods
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /**
     [CustomAlertController 생성자]
     Alert의 Title은 필수, message는 옵셔널
     첫번쨰 버튼의 타이틀은 필수, action은 옵셔널
     두번째 버튼의 타이틀, action 모두 옵셔널
     */
    init(title: String, message: String?, firstActionTitle: String, firstAction: (() -> ())? = nil, secondActionTitle: String? = nil, secondAction:(()->())? = nil) {
        super.init(nibName: nil, bundle: nil)
        
        titleLabel.text = title
        messageLabel.text = message
        
        // 첫번째 버튼 세팅
        firstActionButton.setTitle(firstActionTitle, for: .normal)
        
        firstActionButton.addAction(for: .touchUpInside) { [weak self] in
            self?.dismiss()
            firstAction?()
        }
        
        // 두번쨰 버튼 세팅
        if let secondActionTitle = secondActionTitle {
            // 두번째 버튼의 width Constraint를 세팅하기 위한 플래그 값
            isExistSecondActionButton = true
            secondActionButton.setTitle(secondActionTitle, for: .normal)
            
            secondActionButton.addAction(for: .touchUpInside, { [weak self] in
                self?.dismiss()
                secondAction?()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        view.addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(firstActionButton)
        containerView.addSubview(secondActionButton)

        view.setNeedsUpdateConstraints()
    }

    override func updateViewConstraints() {
        containerView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view)
            make.bottom.equalTo(firstActionButton)
            make.width.equalTo(270)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(50)
            make.left.right.equalTo(containerView)
        }

        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(7)
            make.centerX.equalTo(containerView)
        }

        firstActionButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(40)
            make.left.equalTo(secondActionButton.snp.right)
            make.right.equalTo(containerView)
            make.height.equalTo(40)
        }

        secondActionButton.snp.makeConstraints { make in
            make.top.equalTo(firstActionButton)
            make.left.equalTo(containerView)
            
            let width = isExistSecondActionButton ? 100 : 0
            make.width.equalTo(width)
            make.height.equalTo(40)
        }
        
        super.updateViewConstraints()
    }
    
    func dismiss() {
        view.removeFromSuperview()
        removeFromParent()
    }
}
