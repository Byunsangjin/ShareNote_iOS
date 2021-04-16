//
//  WorkThroughImageCell.swift
//  ShareNote
//
//  Created by sjbyun on 2021/04/16.
//

import FSPagerView
import UIKit

class WorkThroughImageCell: FSPagerViewCell {
    
    // MARK: Constants
    let workThroghImageView = UIImageView()
    
    // MARK: Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        contentView.addSubview(workThroghImageView)
        
        contentView.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        workThroghImageView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(contentView)
        }
        
        super.updateConstraints()
    }
}
