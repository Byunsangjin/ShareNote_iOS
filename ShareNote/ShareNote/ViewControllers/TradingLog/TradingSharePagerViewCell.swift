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
    
    private let shareNameLabel = NameLabel().then {
        $0.text = "주식명"
    }
    
    private let categoryNameLabel = NameLabel().then {
        $0.text = "분류"
    }
    
    private let tradingDateNameLabel = NameLabel().then {
        $0.text = "거래시간"
    }
    
    private let purchasePriceNameLabel = NameLabel().then {
        $0.text = "매수가"
    }
    
    private let appraisedPriceNameLabel = NameLabel().then {
        $0.text = "평가금액"
    }
    
    let contentLabelStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 15
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let shareContentLabel = UILabel().then {
        $0.text = "기아차  011200"
    }
    
    let categoryContentLabel = UILabel().then {
        $0.text = "매수"
    }
    
    let tradingDateContentLabel = UILabel().then {
        $0.text = "2021년 1월 7일 오후 7:43"
    }
    
    let purchasePriceContentLabel = UILabel().then {
        $0.text = "12,000원 | 1주"
    }
    
    let appraisedPriceContentLabel = UILabel().then {
        $0.text = "12,000원"
    }
    
    let editButton = UIButton().then {
        $0.setTitle("수정하기", for: .normal)
        $0.setTitleColor(UIColor(red: 97/255, green: 97/255, blue: 97/255, alpha: 1), for: .normal)
        $0.backgroundColor = .red
    }
    
    let deleteButton = UIButton().then {
        $0.setImage(UIImage(named: "icMainTrash"), for: .normal)
        $0.setImage(UIImage(named: "icMainTrash"), for: .highlighted)
        $0.backgroundColor = .yellow
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
        
        containerView.addSubview(contentLabelStackView)
        contentLabelStackView.addArrangedSubview(shareContentLabel)
        contentLabelStackView.addArrangedSubview(categoryContentLabel)
        contentLabelStackView.addArrangedSubview(tradingDateContentLabel)
        contentLabelStackView.addArrangedSubview(purchasePriceContentLabel)
        contentLabelStackView.addArrangedSubview(appraisedPriceContentLabel)
        
        containerView.addSubview(editButton)
        containerView.addSubview(deleteButton)
        
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
            make.bottom.equalTo(editButton.snp.top).offset(-25)
            make.width.equalTo(52)
        }
        
        contentLabelStackView.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(16)
            make.left.equalTo(nameLabelStackView.snp.right).offset(45)
            make.right.equalTo(containerView)
            make.bottom.equalTo(editButton.snp.top).offset(-25)
        }
        
        editButton.snp.makeConstraints { make in
            make.left.bottom.equalTo(containerView)
            make.width.equalTo(248)
            make.height.equalTo(45)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.right.bottom.equalTo(containerView)
            make.left.equalTo(editButton.snp.right)
            make.height.equalTo(45)
        }
        
        super.updateConstraints()
    }
}

private class NameLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        font = UIFont.systemFont(ofSize: 14)
        textColor = UIColor(red: 189/255, green: 189/255, blue: 189/255, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
