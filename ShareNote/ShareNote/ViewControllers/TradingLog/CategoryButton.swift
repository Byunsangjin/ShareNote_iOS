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
            backgroundColor = isSelected ? UIColor(red: 1, green: 214/255, blue: 8/255, alpha: 1) : .clear
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.titleLabel?.font = UIFont.spoqaHanSans(size: 12)
        
        self.setTitleColor(UIColor(red: 158/255, green: 158/255, blue: 158/255, alpha: 1), for: .normal)
        self.setTitleColor(UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1), for: .selected)
        
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1).cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
