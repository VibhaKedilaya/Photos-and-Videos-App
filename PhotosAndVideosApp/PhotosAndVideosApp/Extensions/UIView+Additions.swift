//
//  UIView+Additions.swift
//  PhotosAndVideosApp
//
//  Created by Vibha R on 13/02/21.
//

import UIKit

// make rounded
extension UIView {
    public func rounded() {
        self.layer.cornerRadius = self.frame.width * 0.5
        self.clipsToBounds = true
    }
    
    @discardableResult
    public func rounded(_ radius: CGFloat) -> Self {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        return self
    }
    
    public func border(with color: UIColor, of width: CGFloat = 1) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}

