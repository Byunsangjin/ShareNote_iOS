//
//  TradingLogTableViewCell.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/27.
//

import Then
import UIKit

class TradingLogTableViewCell: UITableViewCell {
    
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(createButton)
        
        contentView.setNeedsUpdateConstraints()
    }
    
    
    
    override func updateConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.centerX.equalTo(contentView)
        }
        
        createButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.centerX.equalTo(contentView)
        }
        
        super.updateConstraints()
    }
}
