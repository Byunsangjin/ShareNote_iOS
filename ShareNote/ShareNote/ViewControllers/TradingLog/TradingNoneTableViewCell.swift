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
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = UIColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
    }
    
    let createButton = UIButton().then {
        $0.setTitle("작성하러가기", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.titleLabel?.textAlignment = .center
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        $0.titleLabel?.textColor = UIColor(red: 158/255, green: 158/255, blue: 158/255, alpha: 1)
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
            make.top.equalTo(containerView).offset(14)
            make.width.height.equalTo(30)
            make.centerX.equalTo(containerView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom)
            make.left.right.equalTo(containerView)
            make.height.equalTo(20)
        }
        
        createButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalTo(containerView)
            make.bottom.equalTo(containerView.snp.bottom).offset(-21)
            make.height.equalTo(18)
            make.centerX.equalTo(containerView)
        }
        
        super.updateConstraints()
    }
}
