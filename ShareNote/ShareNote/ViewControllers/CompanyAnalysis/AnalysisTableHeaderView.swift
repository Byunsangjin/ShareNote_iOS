//
//  AnalysisTableHeaderView.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/28.
//

import UIKit

class AnalysisTableHeaderView: UIView {
    
    // MARK: Constants
    let titleLabel = UILabel().then {
        $0.text = "작성중이던 기업분석이 있어요!"
        $0.textColor = .grey3
        $0.font = UIFont.spoqaHanSans(size: 12)
    }
    
    // MARK: Methods
    init(title: String?) {
        super.init(frame: CGRect.zero)
        setUI()
        if title != nil {
            titleLabel.text = title
        } else {
            changeTempCellFont()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        addSubview(titleLabel)
        
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(self).offset(20)
            make.centerY.equalTo(self)
        }
        
        super.updateConstraints()
    }
    
    func changeTempCellFont() {
        titleLabel.textColor = .black2
        titleLabel.font = UIFont.spoqaHanSans(size: 16)
    }
}
