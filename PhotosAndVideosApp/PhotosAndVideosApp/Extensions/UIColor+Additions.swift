//
//  UIColor+Additions.swift
//  PhotosAndVideosApp
//
//  Created by Vibha R on 13/02/21.
//

import UIKit
import Foundation

extension UIColor {
    public convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    public convenience init(netHex: Int) {
        self.init(red: (netHex >> 16) & 0xff, green: (netHex >> 8) & 0xff, blue: netHex & 0xff)
    }
    
    public convenience init(netHexWithOpacity hex: Int) {
        var alpha, red, green, blue: Int
        (alpha, red, green, blue) = (hex >> 24 & 0xff, (hex >> 16) & 0xff, (hex >> 8) & 0xff, hex & 0xff)
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
    }
    
    @nonobjc class var lightGreyColor: UIColor {
        return UIColor(netHex: 0x230735).withAlphaComponent(0.5)
    }
    
    @nonobjc class var pinkColor: UIColor {
        return UIColor(netHex: 0xE81244)
    }
}

