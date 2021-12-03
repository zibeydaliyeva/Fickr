//
//  Extension+UIColor.swift
//  Flickr
//
//  Created by Зибейда Алекперли on 02.12.21.
//

import UIKit

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 100) {
        self.init( red: r / 255, green: g / 255, blue:  b / 255,  alpha: a / 100 )
    }
    
    static var mainBGColor: UIColor {
        return UIColor(r: 0, g: 0, b: 0)
    }
    
    static var mainColor: UIColor {
        return UIColor(r: 211, g: 212, b: 215)
    }

    
    static var grayColor: UIColor {
        return UIColor(r: 121, g: 121, b: 121)
    }
    
}


