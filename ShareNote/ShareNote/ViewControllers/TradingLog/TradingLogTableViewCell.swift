//
//  TradingLogTableViewCell.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/28.
//

import UIKit

class TradingLogTableViewCell: UITableViewCell {

    // MARK: Constants
    let containerView = UIView().createCellContainerView()
    
    let titleLabel = UILabel().then {
        $0.text = "기아차 10퍼센트 달성하자"
        $0.textColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.numberOfLines = 0
    }
    
    let createTimeLabel = UILabel().then {
        $0.text = "PM 12:10 작성"
        $0.textColor = UIColor(red: 158/255, green: 158/255, blue: 158/255, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 10)
    }
    
    let tagScrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    let scrollContentView = UIView()
    
    let tagStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillProportionally
        $0.spacing = 4
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }
    
    func setUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        for _ in 0..<10 {
            let button = UIButton().then {
                $0.setTitle("#Test", for: .normal)
                $0.backgroundColor = .green
            }
            tagStackView.addArrangedSubview(button)
        }
        
        let button2 = UIButton().then {
            $0.setTitle("#Testㅁㄴㅇㅁㄴㅇ", for: .normal)
            $0.backgroundColor = .green
        }
        tagStackView.addArrangedSubview(button2)
        
        let button3 = UIButton().then {
            $0.setTitle("#st", for: .normal)
            $0.backgroundColor = .green
        }
        tagStackView.addArrangedSubview(button3)
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(createTimeLabel)
        
        containerView.addSubview(tagScrollView)
        tagScrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(tagStackView)
        
        contentView.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.centerX.equalTo(contentView)
            make.width.equalTo(contentView.snp.width).offset(-40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(16)
            make.left.equalTo(containerView).offset(15)
            make.right.equalTo(createTimeLabel.snp.left).offset(-27)
        }
        
        createTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(16)
            make.right.equalTo(containerView.snp.right).offset(-15)
            make.width.equalTo(64)
        }
        
        tagScrollView.snp.makeConstraints { make in
            make.left.equalTo(containerView).offset(15)
            make.right.equalTo(containerView).offset(-15)
            make.bottom.equalTo(containerView).offset(-16)
            make.height.equalTo(20)
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.top.left.right.equalTo(tagScrollView)
            make.height.equalTo(tagScrollView)
        }
        
        tagStackView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(scrollContentView)
            make.width.equalTo(scrollContentView)
        }
        
        super.updateConstraints()
    }
}
