//
//  QuestionConfirmTableViewCell.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/19.
//

import UIKit

class QuestionConfirmTableViewCell: UITableViewCell {
    // MARK: Constants
    let titleLabel = UILabel().then {
        $0.text = "시가총액은 얼마인가요?"
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Bold)
    }
    
    let trashButton = UIButton().then {
        $0.setImage(UIImage(named: "icTrash"), for: .normal)
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
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(trashButton)
                
        contentView.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(15)
            make.centerY.equalTo(contentView)
        }
        
        trashButton.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.right)
            make.centerY.equalTo(titleLabel)
            make.width.height.equalTo(30)
        }
        
        super.updateConstraints()
    }
}
