//
//  NavigationView.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/07.
//

import UIKit

class NavigationView: UIView {
    
    let titleLabel = UILabel().then {
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 16, style: .Bold)
    }
    
    let backButton = UIButton().then {
        $0.setImage(UIImage(named: "iconsGotobac"), for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.layer.addBorder([.bottom], color: .grey6, width: 1)
    }
    
    func setUI() {
        backgroundColor = UIColor.white
        
        self.addSubview(titleLabel)
        self.addSubview(backButton)
    }
    
    override func updateConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
        }
        
        backButton.snp.makeConstraints { make in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
            make.width.height.equalTo(30)
        }
        
        super.updateConstraints()
    }
}
