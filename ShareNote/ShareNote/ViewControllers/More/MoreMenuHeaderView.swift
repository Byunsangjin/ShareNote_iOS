//
//  MoreMenuHeaderView.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/07.
//

import UIKit

class MoreMenuHeaderView: UIView {
    
    let containerView = UIView().then {
        $0.backgroundColor = .white
    }
    
    let titleLabel = UILabel().then {
        $0.textColor = .grey4
        $0.font = UIFont.spoqaHanSans(size: 12, style: .Regular)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        backgroundColor = UIColor.whiteTwo
        
        addSubview(containerView)
        containerView.addSubview(titleLabel)
    }
    
    override func updateConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(5)
            make.left.right.equalTo(self)
            make.bottom.equalTo(self).offset(-1)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(containerView).offset(20)
            make.bottom.equalTo(containerView).offset(-5)
        }
        
        super.updateConstraints()
    }
}
