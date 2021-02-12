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
}
