//
//  TradingLogTableViewCell.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/27.
//

import Then
import UIKit

class TradingNoneTableViewCell: UITableViewCell {
    
    let containerView = UIView().then {
        $0.layer.cornerRadius = 7
        $0.layer.borderColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1).cgColor
        $0.layer.borderWidth = 1
        $0.layer.applySketchShadow()
    }
    
    let iconImageView = UIImageView().then {
        $0.image = UIImage(named: "icNote")
    }
    
    let titleLabel = UILabel().then {
        $0.text = "작성한 매매일지가 없어요"
    }
    
    let createButton = UIButton().then {
        $0.setTitle("작성하러가기", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
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
    
    func setUI() {
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        
        containerView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(createButton)
        
        contentView.setNeedsUpdateConstraints()
    }
    
    
    
    override func updateConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.centerX.equalTo(contentView)
            make.width.equalTo(contentView.snp.width).offset(-40)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(14)
            make.width.height.equalTo(30)
            make.centerX.equalTo(contentView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom)
            make.centerX.equalTo(contentView)
        }
        
        createButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.centerX.equalTo(contentView)
        }
        
        super.updateConstraints()
    }
}
