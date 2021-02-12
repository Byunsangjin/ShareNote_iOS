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
}
