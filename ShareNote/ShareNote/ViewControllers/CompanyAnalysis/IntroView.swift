//
//  IntroView.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/11.
//

import UIKit

class IntroView: UIView {
    let stepLabel = UILabel().then {
        $0.textColor = .mainColor
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Bold)
    }
    
    let titleLabel = UILabel().then {
        $0.textColor = .black2
        $0.font = UIFont.spoqaHanSans(size: 18)
    }
    
    let descriptionLabel = UILabel().then {
        $0.textColor = .grey2
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
        $0.numberOfLines = 0
    }
    
    init(numberOfStep: Int, title: String, description: String) {
        super.init(frame: CGRect.zero)
        
        stepLabel.text = "STEP\(numberOfStep)"
        titleLabel.text = title
        descriptionLabel.text = description
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        self.backgroundColor = .white
        
        self.addSubview(stepLabel)
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        
        self.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        stepLabel.snp.makeConstraints { make in
            make.top.left.equalTo(self)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(stepLabel.snp.bottom).offset(7)
            make.left.equalTo(stepLabel)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(stepLabel)
        }
        
        super.updateConstraints()
    }
}
