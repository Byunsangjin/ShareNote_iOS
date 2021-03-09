//
//  MoveDetailTableViewCell.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/09.
//

import UIKit

class MoveDetailTableViewCell: UITableViewCell {

    // MARK: Constants
    let titleLabel = UILabel().then {
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
    }
    
    let moveDetailIconImage = UIImageView().then {
        $0.image = UIImage(named: "iconsFold")
        $0.tintColor = .grey5
    }
    
    // MARK: Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(moveDetailIconImage)
        
        contentView.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(20)
            make.centerY.equalTo(contentView)
        }
        
        moveDetailIconImage.snp.makeConstraints { make in
            make.right.equalTo(contentView).offset(-10)
            make.centerY.equalTo(contentView)
            make.width.height.equalTo(30)
        }
        
        super.updateConstraints()
    }
}
