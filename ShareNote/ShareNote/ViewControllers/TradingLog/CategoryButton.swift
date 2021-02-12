//
//  CategoryButton.swift
//  ShareNote
//
//  Created by sjbyun on 2021/02/07.
//

import UIKit

class CategoryButton: UIButton {
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? UIColor.mainColor : .clear
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.titleLabel?.font = UIFont.spoqaHanSans(size: 12)
        
        self.setTitleColor(UIColor.grey4, for: .normal)
        self.setTitleColor(UIColor.black2, for: .selected)
        
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.grey6.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
