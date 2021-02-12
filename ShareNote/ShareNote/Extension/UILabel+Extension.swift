//
//  UILabel+Extension.swift
//  ShareNote
//
//  Created by sjbyun on 2021/02/05.
//

import UIKit

extension UILabel {
    class func createLabel(font: UIFont, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = textColor
        
        return label
    }
    
    /**
     이용약관 동의의 관련된 Label을 만들떄 사용하는 메소드
     AttributeText 속성을 이용하여 부분적으로 Label Text의 폰트 크기를 달리함.
     */
    class func createAttributeLabel(text: String) -> UILabel {
        let label = UILabel()
        
        let font = UIFont.spoqaHanSans(size: 16, style: .Regular)
        let attributeText = NSMutableAttributedString(string: text, attributes: [.font : font])
        
        let bracketFont = UIFont.spoqaHanSans(size: 12, style: .Regular)
        let bracketText = String(text.split(separator: " ").last!)
        attributeText.addAttribute(.font, value: bracketFont, range: (text as NSString).range(of: bracketText))

        label.attributedText = attributeText
        label.textColor = UIColor.black1
        
        return label
    }
}
