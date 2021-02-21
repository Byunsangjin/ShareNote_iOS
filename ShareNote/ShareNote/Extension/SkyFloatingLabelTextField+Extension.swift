//
//  SkyFloatingLabelTextField+Extension.swift
//  ShareNote
//
//  Created by sjbyun on 2021/02/21.
//

import SkyFloatingLabelTextField

extension SkyFloatingLabelTextField {
    class func createTextField(placeholder: String? = nil) -> SkyFloatingLabelTextField {
        let textField = SkyFloatingLabelTextField()
        
        textField.textColor = .black2
        textField.font = UIFont.spoqaHanSans(size: 20, style: .Regular)
        
        textField.lineHeight = 1
        textField.selectedLineHeight = 2
        textField.selectedLineColor = .mainColor
        
        guard let placeholder = placeholder else {
            return textField
        }
        
        textField.placeholder = placeholder
        textField.placeholderColor = .grey4
        textField.placeholderFont = UIFont.spoqaHanSans(size: 20)
        textField.title = placeholder
        textField.titleFont = UIFont.spoqaHanSans(size: 12, style: .Regular)
        textField.selectedTitleColor = .grey4
        
        return textField
    }
}
