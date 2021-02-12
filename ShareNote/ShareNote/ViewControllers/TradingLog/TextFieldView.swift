//
//  TextFieldView.swift
//  ShareNote
//
//  Created by sjbyun on 2021/02/07.
//

import UIKit

class TextFieldView: UIView {
    let textField = UITextField().then {
        $0.textAlignment = .right
        $0.textColor = UIColor.black2
    }
    
    var label = UILabel().then {
        $0.textColor = UIColor.grey2
        $0.font = UIFont.spoqaHanSans(size: 14, style: .Regular)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        backgroundColor = UIColor.tempGreyColor
        layer.cornerRadius = 7
        
        addSubview(textField)
        addSubview(label)
    }
    
    override func updateConstraints() {
        textField.snp.makeConstraints { make in
            make.left.lessThanOrEqualTo(self).offset(10)
            make.right.equalTo(label.snp.left).offset(-5)
            make.centerY.equalTo(self)
        }
        
        label.snp.makeConstraints { make in
            make.right.equalTo(self).offset(-10)
            make.centerY.equalTo(self)
        }
        
        super.updateConstraints()
    }
}
