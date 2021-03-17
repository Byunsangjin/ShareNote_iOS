//
//  CategoryTableViewCell.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/16.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    // MARK: Constants
    let containerView = UIView.createTradingShareCellView()
    
    let titleLabel = UILabel().then {
        $0.text = "이런 저런 이런저런에 대해 알아보세요."
        $0.textColor = .grey3
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Bold)
    }
    
    let arrowImageView = UIImageView().then {
        $0.image = UIImage(named: "icArrowDown")
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
        containerView.addSubview(arrowImageView)
        
        contentView.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.centerX.equalTo(contentView)
            make.width.equalTo(contentView.snp.width).offset(-40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(containerView).offset(15)
            make.right.equalTo(arrowImageView.snp.left).offset(-15)
            make.centerY.equalTo(containerView)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.right.equalTo(containerView).offset(-7)
            make.centerY.equalTo(containerView)
            make.width.height.equalTo(30)
        }
        
        super.updateConstraints()
    }
    
    func changeLayer() {
        containerView.layer.shadowOpacity = 0
//        containerView.layer.borderWidth = 0
        containerView.layer.addBorder([.bottom], color: .white, width: 1)
//        containerView.layer.cornerRadius = 7
    }
}
