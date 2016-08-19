//
//  PrettyButton.swift
//  AVCapture
//
//  Created by Kyle Anderson on 7/6/16.
//  Copyright © 2016 Kyle Anderson. All rights reserved.
//


import UIKit

@IBDesignable
class PrettyButton: UIButton {
    
    @IBInspectable var radius : CGFloat = 10.0
    @IBInspectable var lineWidth : CGFloat = 2.0
    @IBInspectable var color : UIColor = .whiteColor()
    @IBInspectable var colorAlphaValue : CGFloat = 0.3
    
    private var colorWithAlpha: UIColor {
        get {
            return color.colorWithAlphaComponent(colorAlphaValue)
        }
    }
    
    override func drawRect(rect: CGRect) {
        
        let buttonPath = UIBezierPath(roundedRect: rect, cornerRadius: radius)
        buttonPath.addClip()
        color.setStroke()
        colorWithAlpha.setFill()
        buttonPath.closePath()
        buttonPath.lineWidth = lineWidth
        buttonPath.stroke()
        buttonPath.fill()
        print(rect)
        
        self.titleLabel?.textColor = color
    }
    
    
    
}
