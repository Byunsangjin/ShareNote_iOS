//
//  CALayer+Extension.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/28.
//

import UIKit

extension CALayer {
    func applySketchShadow(color: UIColor = .black,
                           alpha: Float = 0.05,
                           x: CGFloat = 0,
                           y: CGFloat = 1,
                           blur: CGFloat = 2,
                           spread: CGFloat = 0) {
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
