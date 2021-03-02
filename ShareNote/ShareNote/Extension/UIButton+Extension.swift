//
//  UIButton+Extension.swift
//  ShareNote
//
//  Created by sjbyun on 2021/02/13.
//

import UIKit

extension UIButton {
    class func createCheckButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: "checkN"), for: .normal)
        button.setImage(UIImage(named: "checkY"), for: .selected)
        
        return button
    }
    
    class func createNumberButton(number: String) -> UIButton {
        let button = UIButton()
        button.setTitle(number, for: .normal)
        button.setTitleColor(.black2, for: .normal)
        button.titleLabel?.font = UIFont.spoqaHanSans(size: 18, style: .Bold)
        
        return button
    }    
}
