//
//  MoreMenuTableViewCell.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/07.
//

import UIKit

class MoreMenuTableViewCell: UITableViewCell {
    // MARK: Constants
    let titleLabel = UILabel().then {
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
    }
    
    let detailImage = UIImageView().then {
        $0.image = UIImage(named: "iconsFold")
        $0.tintColor = .grey5
    }
    
    let descriptionLabel = UILabel().then {
        $0.textColor = .grey3
        $0.font = UIFont.spoqaHanSans(size: 12, style: .Regular)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(detailImage)
                
        contentView.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(20)
            make.centerY.equalTo(contentView)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.right.equalTo(detailImage.snp.left)
            make.centerY.equalTo(contentView)
        }
        
        detailImage.snp.makeConstraints { make in
            make.right.equalTo(contentView).offset(-10)
            make.centerY.equalTo(contentView)
            make.width.height.equalTo(30)
        }
        
        super.updateConstraints()
    }
}
