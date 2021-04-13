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
    
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(backgroundImage, for: state)
    }
}
