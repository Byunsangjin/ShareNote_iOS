//
//  UIView+Extension.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/28.
//

import UIKit

extension UIView {
    class func createCellContainerView() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        
        view.layer.cornerRadius = 7
        view.layer.borderColor = UIColor.grey7.cgColor
        view.layer.borderWidth = 1
        view.layer.applySketchShadow()
        
        return view
    }
    
    class func createTradingShareCellView() -> UIView {
        let view = UIView.createCellContainerView()
        view.layer.borderColor = UIColor.whiteTwo.cgColor
        view.layer.applySketchShadow(color: .black1, alpha: 0.05, x: 0, y: 1, blur: 10, spread: 0)
        
        return view
    }
    
    enum ViewSide: String {
        case Left = "Left", Right = "Right", Top = "Top", Bottom = "Bottom"
    }
    
    func addBottomLine() {
        let border = CALayer()
        border.borderColor = UIColor.whiteTwo.cgColor
        border.frame = CGRect(x: 20, y: frame.height - 1, width: frame.width - 40, height: 1)
        border.borderWidth = 1
        
        layer.addSublayer(border)
    }
}
