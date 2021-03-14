//
//  CompanySelectionView.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/14.
//

import UIKit

class CompanySelectionView: UIView {
    
    // MARK: Constants
    let numberContainerView = UIView().then {
        $0.layer.cornerRadius = 11
        $0.backgroundColor = .mainColor
    }
    
    let numberLabel = UILabel().then {
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 16, style: .Regular)
    }
    
    let titleLabel = UILabel().then {
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 16)
    }
    
    let iconImageView = UIImageView().then {
        $0.image = UIImage(named: "iconsFold")
        $0.tintColor = .black1
    }
    
    let changeButton = UIButton().then {
        let attributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue,
                                                                  NSAttributedString.Key.font: UIFont.spoqaHanSans(size: 12, style: .Regular)]
        let underlineAttributedString = NSAttributedString(string: "변경하기", attributes: attributes)
        $0.setAttributedTitle(underlineAttributedString, for: .normal)
        $0.isHidden = true
    }
    
    // MARK: Methods
    init(numberOfStep: Int, title: String, isEnable: Bool) {
        super.init(frame: CGRect.zero)
        
        numberLabel.text = "\(numberOfStep)"
        titleLabel.text = title
        self.layer.cornerRadius = 7
                
        applyShadow()
        
        if isEnable == false {
            disableView()
        }
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        self.addSubview(numberContainerView)
        numberContainerView.addSubview(numberLabel)
        self.addSubview(titleLabel)
        self.addSubview(iconImageView)
        self.addSubview(changeButton)
        
        self.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        numberContainerView.snp.makeConstraints { make in
            make.left.equalTo(self).offset(24)
            make.centerY.equalTo(self)
            make.width.height.equalTo(22)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(numberContainerView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(numberContainerView.snp.right).offset(13)
            make.centerY.equalTo(numberContainerView)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.right.equalTo(self).offset(-10)
            make.centerY.equalTo(numberContainerView)
            make.width.height.equalTo(30)
        }
        
        changeButton.snp.makeConstraints { make in
            make.right.equalTo(self).offset(-20)
            make.centerY.equalTo(self)
        }
        
        super.updateConstraints()
    }
    
    func applyShadow() {
        self.backgroundColor = .white
        self.alpha = 0.94
        self.layer.applySketchShadow(color: .black1, alpha: 0.13, x: 0, y: 1, blur: 10, spread: 0)
    }
    
    func disableView() {
        self.backgroundColor = .grey7
        numberContainerView.backgroundColor = .grey5
        numberLabel.textColor = .grey6
        titleLabel.textColor = .grey4
        iconImageView.isHidden = true
        
        if numberLabel.text?.elementsEqual("1") == true {
            iconImageView.isHidden = true
            changeButton.isHidden = false
        }
        
        self.layer.shadowOpacity = 0
    }
    
    func enableView() {
        self.layer.shadowOpacity = 1
        
        self.backgroundColor = .white
        numberContainerView.backgroundColor = .mainColor
        numberLabel.textColor = .black2
        titleLabel.textColor = .black2
        iconImageView.isHidden = false
        
        if numberLabel.text?.elementsEqual("1") == true {
            iconImageView.isHidden = false
            changeButton.isHidden = true
        }
        
        self.layer.shadowOpacity = 0.13
    }
}
