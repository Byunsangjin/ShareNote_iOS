//
//  QuestListTableViewCell.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/22.
//

import UIKit

class QuestListTableViewCell: UITableViewCell {
    // MARK: Constants
    let containerView = UIView.createTradingShareCellView()
    
    let titleLabel = UILabel().then {
        $0.text = "시가총액은 얼마인가요?"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Bold)
    }
    
    let checkImageView = UIImageView().then {
        $0.image = UIImage(named: "icCheck")
        $0.isHidden = true
    }
    
    let stateLabel = UILabel().then {
        $0.text = "미작성"
        $0.textColor = .blue
        $0.font = UIFont.spoqaHanSans(size: 11)
    }
    
    // MARK: Methods
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
    
    func setUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(checkImageView)
        containerView.addSubview(stateLabel)
                
        contentView.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.centerX.equalTo(contentView)
            make.width.equalTo(contentView.snp.width).offset(-40)
            make.height.equalTo(55)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(containerView).offset(15)
            make.right.lessThanOrEqualTo(checkImageView.snp.left).offset(-16)
            make.centerY.equalTo(containerView)
        }
        
        checkImageView.snp.makeConstraints { make in
            make.right.equalTo(stateLabel.snp.left).offset(-5)
            make.width.equalTo(12.5)
            make.height.equalTo(9.5)
            make.centerY.equalTo(containerView)
        }
        
        stateLabel.snp.makeConstraints { make in
            make.right.equalTo(containerView).offset(-15)
            make.centerY.equalTo(containerView)
        }
        
        super.updateConstraints()
    }
    
    func complete() {
        stateLabel.text = "작성완료"
        stateLabel.textColor = .grey3
        checkImageView.isHidden = false
    }
}
