//
//  InputTextViewController.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/22.
//

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
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(naviTitleLabel)
        view.addSubview(closeButton)
        
        view.addSubview(titleContainerView)
        view.addSubview(titleLabel)
        
        view.addSubview(textView)
        
        view.addSubview(saveButton)
        
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
        
        super.updateViewConstraints()
    }
}
