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
        $0.textColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
    }
    
    var label = UILabel().then {
        $0.textColor = UIColor(red: 97/255, green: 97/255, blue: 97/255, alpha: 1)
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
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
