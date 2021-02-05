//
//  UILabel+Extension.swift
//  ShareNote
//
//  Created by sjbyun on 2021/02/05.
//

import UIKit

extension UILabel {
    func createLabel(font: UIFont, textColor: UIColor) -> UILabel {
        self.font = font
        self.textColor = textColor
        
        return self
    }
}
