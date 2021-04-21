//
//  WorkThroughImageCell.swift
//  ShareNote
//
//  Created by sjbyun on 2021/04/16.
//

import FSPagerView
import UIKit

class WorkThroughImageCell: FSPagerViewCell {
    
    // MARK: Constants
    let titleLabel = UILabel().then {
        $0.font = UIFont.spoqaHanSans(size: 22, style: .Bold)
        $0.textColor = .black2
        $0.textAlignment = .center
    }
    
    let descriptionLabel = UILabel().then {
        $0.font = UIFont.spoqaHanSans(size: 16)
        $0.textColor = .black2
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    let workThroghImageView = UIImageView()
    
    // MARK: Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        contentView.layer.shadowRadius = 0
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(workThroghImageView)
        
        contentView.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(95)
            make.left.right.equalTo(contentView)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(18)
            make.left.right.equalTo(titleLabel)
        }
        
        workThroghImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(108)
            make.left.right.equalTo(contentView)
            make.height.equalTo(248)
        }
        
        super.updateConstraints()
    }
}
