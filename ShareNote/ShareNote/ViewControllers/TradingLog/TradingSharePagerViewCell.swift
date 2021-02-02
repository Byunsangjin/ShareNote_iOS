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
    
    let nameLabelStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 15
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let shareNameLabel = NameLabel().then {
        $0.text = "주식명"
    }
    
    let categoryNameLabel = NameLabel().then {
        $0.text = "분류"
    }
    
    let tradingDateNameLabel = NameLabel().then {
        $0.text = "거래시간"
    }
    
    let purchasePriceNameLabel = NameLabel().then {
        $0.text = "매수가"
    }
    
    let appraisedPriceNameLabel = NameLabel().then {
        $0.text = "평가금액"
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
        
        containerView.addSubview(nameLabelStackView)
        nameLabelStackView.addArrangedSubview(shareNameLabel)
        nameLabelStackView.addArrangedSubview(categoryNameLabel)
        nameLabelStackView.addArrangedSubview(tradingDateNameLabel)
        nameLabelStackView.addArrangedSubview(purchasePriceNameLabel)
        nameLabelStackView.addArrangedSubview(appraisedPriceNameLabel)
        
        contentView.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(1.5)
            make.bottom.equalTo(contentView).offset(-1.5)
            make.centerX.equalTo(contentView)
            make.width.equalTo(contentView.snp.width).offset(-40)
        }
        
        nameLabelStackView.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(16)
            make.left.equalTo(containerView).offset(20)
            make.bottom.equalTo(containerView).offset(-25)
            make.width.equalTo(60)
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
