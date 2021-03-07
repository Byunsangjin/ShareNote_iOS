//
//  TextField+Extension.swift
//  ShareNote
//
//  Created by sjbyun on 2021/03/07.
//

import UIKit

extension UITextField {
    class func createPasswordTextField() -> UITextField {
        let textField = UITextField()
        
        textField.borderStyle = .none
        textField.backgroundColor = .whiteTwo
        
        textField.isSecureTextEntry = true
        
        textField.layer.cornerRadius = 5
        
        // padding 처리
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        
        return textField
    }
}
