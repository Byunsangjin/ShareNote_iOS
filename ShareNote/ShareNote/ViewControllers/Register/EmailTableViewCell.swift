//
//  EmailTableViewCell.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/03.
//

import UIKit

class EmailTableViewCell: UITableViewCell {
    // MARK: Constants
    let checkButton = UIButton().then {
        if #available(iOS 13.0, *) {
            let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 28, weight: .black)
            let image = UIImage(systemName: "checkmark.circle.fill", withConfiguration: homeSymbolConfiguration)
            $0.setImage(image, for: .normal)
        } else {
            $0.imageView?.image = nil
        }
    }
    
    let emailLabel = UILabel().then {
        $0.text = "naver.com"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        contentView.addSubview(checkButton)
        contentView.addSubview(emailLabel)
        
        contentView.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        checkButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView.snp.left).offset(20)
            make.width.height.equalTo(28)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(checkButton.snp.right).offset(20)
        }
        
        super.updateConstraints()
    }
}
