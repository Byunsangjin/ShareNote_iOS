//
//  TradingSharePagerViewCell.swift
//  ShareNote
//
//  Created by sjbyun on 2021/02/01.
//

import UIKit
import FSPagerView

class TradingSharePagerViewCell: FSPagerViewCell {
    
    let containerView = UIView().createTradingShareCellView()
    
    let shareNameLabel = UILabel().then {
        $0.text = "주식명"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        self.contentView.layer.shadowRadius = 0
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(shareNameLabel)
        
        contentView.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(1.5)
            make.bottom.equalTo(contentView).offset(-1.5)
            make.centerX.equalTo(contentView)
            make.width.equalTo(contentView.snp.width).offset(-40)
        }
        
        shareNameLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(16)
            make.left.equalTo(containerView).offset(20)
        }
        
        super.updateConstraints()
    }
}

class NameLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        font = UIFont.systemFont(ofSize: 14)
        textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
