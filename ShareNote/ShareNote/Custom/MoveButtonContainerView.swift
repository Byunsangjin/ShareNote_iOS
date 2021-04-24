//
//  MoveButtonContainerView.swift
//  ShareNote
//
//  Created by sjbyun on 2021/04/24.
//

import UIKit

class MoveButtonContainerView: UIView {
    // MARK: Constants
    let cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.grey2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
    }
    
    let nextButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.grey2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
    }
    
    // MARK: Methods
    init() {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        self.backgroundColor = .white
        
        self.addSubview(cancelButton)
        self.addSubview(nextButton)
        
        self.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        cancelButton.snp.makeConstraints { make in
            make.left.equalTo(self).offset(20)
            make.centerY.equalTo(self)
        }
        
        nextButton.snp.makeConstraints { make in
            make.right.equalTo(self).offset(-20)
            make.centerY.equalTo(self)
        }
        
        super.updateConstraints()
    }
}
