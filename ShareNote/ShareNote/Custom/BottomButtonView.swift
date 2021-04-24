//
//  BottomButtonView.swift
//  ShareNote
//
//  Created by sjbyun on 2021/04/24.
//

import UIKit

class BottomButtonView: UIView {
    // MARK: Constants
    let button = UIButton().then {
        $0.setTitleColor(.black2, for: .normal)
        $0.titleLabel?.font = UIFont.spoqaHanSans(size: 16 )
        $0.backgroundColor = .mainColor
    }
    
    // MARK: Methods
    init(title: String) {
        super.init(frame: .zero)
        setUI()
        button.setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        self.backgroundColor = .mainColor
        
        self.addSubview(button)
        
        self.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        button.snp.makeConstraints { make in
            make.top.left.right.equalTo(self)
            make.height.equalTo(59)
        }
        
        super.updateConstraints()
    }
}
