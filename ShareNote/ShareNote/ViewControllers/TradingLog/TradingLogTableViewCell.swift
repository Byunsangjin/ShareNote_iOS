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
        $0.text = "기아차 10퍼센트 달성하자asdfk;lsdakfsadffdsfkjsdflksjdkl"
        $0.textColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    let createTimeLabel = UILabel().then {
        $0.text = "PM 12:10 작성"
        $0.textColor = UIColor(red: 158/255, green: 158/255, blue: 158/255, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 10)
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
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(createTimeLabel)
        
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
            make.right.greaterThanOrEqualTo(createTimeLabel.snp.left).offset(27)
        }
        
        createTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(16)
            make.right.equalTo(containerView.snp.right).offset(-15)
        }
        
        super.updateConstraints()
    }
}
