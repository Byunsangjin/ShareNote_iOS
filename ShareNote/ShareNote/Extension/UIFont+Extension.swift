//
//  UIFont+Extension.swift
//  ShareNote
//
//  Created by sjbyun on 2021/02/12.
//

import UIKit

enum SpoqaHanSansStyle: String {
    case Thin = "Spoqa Han Sans Neo Thin"
    case Light = "Spoqa Han Sans Neo Light"
    case Regular = "Spoqa Han Sans Neo Regular"
    case Medium = "Spoqa Han Sans Neo Medium"
    case Bold = "Spoqa Han Sans Neo Bold"
}

extension UIFont {
    class func spoqaHanSans(size: CGFloat, style: SpoqaHanSansStyle = .Medium) -> UIFont {
        let fontName = style.rawValue
        guard let font = UIFont(name: fontName, size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        
        return font
    }
}
