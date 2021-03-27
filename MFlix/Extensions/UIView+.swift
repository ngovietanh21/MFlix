//
//  UIView+.swift
//  MFlix
//
//  Created by Viet Anh on 5/6/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation

@IBDesignable
extension UIView {
    
    func makeRounded() {
        layer.masksToBounds = false
        cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
    
    func makeSquare() {
        layer.masksToBounds = false
        cornerRadius = 0
        clipsToBounds = true
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        set {
            self.layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        set {
            self.layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            self.layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer().then {
            $0.colors = [colorBottom.cgColor, colorTop.cgColor]
            $0.startPoint = CGPoint(x: 0.5, y: 1.0)
            $0.endPoint = CGPoint(x: 0.5, y: 0.0)
            $0.locations = [0, 1]
            $0.frame = bounds
        }
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
