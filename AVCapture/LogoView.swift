//
//  LogoView.swift
//  AVCapture
//
//  Created by Kyle Anderson on 7/7/16.
//  Copyright © 2016 Kyle Anderson. All rights reserved.
//

import UIKit

@IBDesignable
class LogoView: UIView {

    @IBInspectable var fillColor : UIColor = UIColor.whiteColor()
    
    override func drawRect(rect: CGRect) {
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPoint(x: 64, y: 0))
        bezierPath.addCurveToPoint(CGPoint(x: 14.91, y: 22.97), controlPoint1: CGPoint(x: 44.27, y: 0), controlPoint2: CGPoint(x: 26.65, y: 8.94))
        bezierPath.addLineToPoint(CGPoint(x: 37.44, y: 62))
        bezierPath.addLineToPoint(CGPoint(x: 72.88, y: 0.62))
        bezierPath.addCurveToPoint(CGPoint(x: 64, y: 0), controlPoint1: CGPoint(x: 69.97, y: 0.22), controlPoint2: CGPoint(x: 67.01, y: 0))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPoint(x: 75, y: 0.97))
        bezierPath.addLineToPoint(CGPoint(x: 52.44, y: 40))
        bezierPath.addLineToPoint(CGPoint(x: 123.34, y: 40))
        bezierPath.addCurveToPoint(CGPoint(x: 75, y: 0.97), controlPoint1: CGPoint(x: 115.17, y: 19.82), controlPoint2: CGPoint(x: 97.01, y: 4.78))
        bezierPath.addLineToPoint(CGPoint(x: 75, y: 0.97))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPoint(x: 13.56, y: 24.62))
        bezierPath.addCurveToPoint(CGPoint(x: -0, y: 64), controlPoint1: CGPoint(x: 5.07, y: 35.48), controlPoint2: CGPoint(x: -0, y: 49.15))
        bezierPath.addCurveToPoint(CGPoint(x: 3.87, y: 86), controlPoint1: CGPoint(x: -0, y: 71.73), controlPoint2: CGPoint(x: 1.36, y: 79.14))
        bezierPath.addLineToPoint(CGPoint(x: 49, y: 86))
        bezierPath.addLineToPoint(CGPoint(x: 13.56, y: 24.62))
        bezierPath.addLineToPoint(CGPoint(x: 13.56, y: 24.62))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPoint(x: 79, y: 42))
        bezierPath.addLineToPoint(CGPoint(x: 114.44, y: 103.38))
        bezierPath.addCurveToPoint(CGPoint(x: 128, y: 64), controlPoint1: CGPoint(x: 122.92, y: 92.52), controlPoint2: CGPoint(x: 128, y: 78.85))
        bezierPath.addCurveToPoint(CGPoint(x: 124.13, y: 42), controlPoint1: CGPoint(x: 128, y: 56.27), controlPoint2: CGPoint(x: 126.64, y: 48.86))
        bezierPath.addLineToPoint(CGPoint(x: 79, y: 42))
        bezierPath.addLineToPoint(CGPoint(x: 79, y: 42))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPoint(x: 90.56, y: 66))
        bezierPath.addLineToPoint(CGPoint(x: 55.12, y: 127.38))
        bezierPath.addCurveToPoint(CGPoint(x: 64, y: 128), controlPoint1: CGPoint(x: 58.03, y: 127.78), controlPoint2: CGPoint(x: 60.99, y: 128))
        bezierPath.addCurveToPoint(CGPoint(x: 113.09, y: 105.03), controlPoint1: CGPoint(x: 83.72, y: 128), controlPoint2: CGPoint(x: 101.35, y: 119.06))
        bezierPath.addLineToPoint(CGPoint(x: 90.56, y: 66))
        bezierPath.closePath()
        bezierPath.moveToPoint(CGPoint(x: 4.66, y: 88))
        bezierPath.addCurveToPoint(CGPoint(x: 53, y: 127.03), controlPoint1: CGPoint(x: 12.83, y: 108.18), controlPoint2: CGPoint(x: 30.99, y: 123.22))
        bezierPath.addLineToPoint(CGPoint(x: 75.56, y: 88))
        bezierPath.addLineToPoint(CGPoint(x: 4.66, y: 88))
        bezierPath.closePath()
        bezierPath.miterLimit = 4;
        
        fillColor.setFill()
        bezierPath.fill()

    }
 

}
