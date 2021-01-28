//
//  UIView+Extension.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/28.
//

import UIKit

extension UIView {
    func createCellContainerView() -> UIView {
        backgroundColor = .white
        
        layer.cornerRadius = 7
        layer.borderColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1).cgColor
        layer.borderWidth = 1
        layer.applySketchShadow()
        
        return self
    }
}
