//
//  SearchTableViewCell.swift
//  ShareNote
//
//  Created by sjbyun on 2021/06/25.
//

import UIKit
import Tabman

class SearchTableViewCell: UITableViewCell {
    
    // MARK: Constants
    let iconImageView = UIImageView().then {
        $0.image = UIImage(named: "icSearchB")
    }
    
    let searchTextLabel = UILabel().then {
        $0.textColor = .black2
        $0.font = .spoqaHanSans(size: 14, style: .Regular)
    }
    
    // MARK: Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        self.selectionStyle = .none
        
        contentView.addSubview(iconImageView)
        
        contentView.addSubview(searchTextLabel)
        
        contentView.setNeedsUpdateConstraints()
    }

    override func updateConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(20)
            make.centerY.equalTo(contentView)
            make.width.height.equalTo(30)
        }
        
        searchTextLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(6)
            make.right.equalTo(contentView).offset(-20)
            make.centerY.equalTo(contentView)
        }
        
        super.updateConstraints()
    }
}
