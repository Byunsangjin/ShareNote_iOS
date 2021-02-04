//
//  ArticlePagerViewCell.swift
//  ShareNote
//
//  Created by sjbyun on 2021/02/04.
//

import FSPagerView
import UIKit

class ArticlePagerViewCell: FSPagerViewCell {
    let containerView = UIView().createTradingShareCellView()
        
    let editButton = UIButton().then {
        $0.setTitle("기사 본문 보기", for: .normal)
        $0.setTitleColor(UIColor(red: 97/255, green: 97/255, blue: 97/255, alpha: 1), for: .normal)
        $0.backgroundColor = .red
    }
    
    let deleteButton = UIButton().then {
        $0.setImage(UIImage(named: "icMainTrash"), for: .normal)
        $0.setImage(UIImage(named: "icMainTrash"), for: .highlighted)
        $0.backgroundColor = .yellow
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        self.contentView.layer.shadowRadius = 0
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        contentView.addSubview(containerView)
        
        
        
        containerView.addSubview(editButton)
        containerView.addSubview(deleteButton)
        
        contentView.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(1.5)
            make.bottom.equalTo(contentView).offset(-1.5)
            make.centerX.equalTo(contentView)
            make.width.equalTo(contentView.snp.width).offset(-40)
        }
        
        editButton.snp.makeConstraints { make in
            make.left.bottom.equalTo(containerView)
            make.width.equalTo(248)
            make.height.equalTo(45)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.right.bottom.equalTo(containerView)
            make.left.equalTo(editButton.snp.right)
            make.height.equalTo(45)
        }
        
        super.updateConstraints()
    }
}
