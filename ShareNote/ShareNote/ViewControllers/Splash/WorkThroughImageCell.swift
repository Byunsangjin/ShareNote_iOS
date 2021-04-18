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
        $0.text = "Share Note"
        $0.font = UIFont.spoqaHanSans(size: 22, style: .Bold)
        $0.textColor = .black2
        $0.textAlignment = .center
    }
    
    let descriptionLabel = UILabel().then {
        $0.text = "쉐어노트와 함께 건강한 주식투자를 시작하세요"
        $0.font = UIFont.spoqaHanSans(size: 16)
        $0.textColor = .black2
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    let workThroghImageView = UIImageView()
    
    // MARK: Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView?.image = UIImage(named: "icIllust01")
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(workThroghImageView)
        
        contentView.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
//        titleLabel.snp.makeConstraints { make in
//            make.bottom.equalTo(descriptionLabel).offset(-18)
//            make.width.equalTo(contentView)
//        }
//        
//        descriptionLabel.snp.makeConstraints { make in
//            make.bottom.equalTo(workThroghImageView).offset(90)
//            make.width.equalTo(contentView)
//        }
        
        workThroghImageView.snp.makeConstraints { make in
            make.bottom.equalTo(contentView)
            make.centerX.equalTo(contentView)
            make.width.equalTo(375)
            make.height.equalTo(210)
        }
        
        super.updateConstraints()
    }
}
