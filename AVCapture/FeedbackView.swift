//
//  FeedbackView.swift
//  AVCapture
//
//  Created by Kyle Anderson on 7/4/16.
//  Copyright © 2016 Kyle Anderson. All rights reserved.
//

import UIKit

@IBDesignable
class FeedbackView: UIView {
    
    
    enum FeedbackType {
        case FeedbackSuccess
    }
    
    var type : FeedbackType?

    
    override func drawRect(rect: CGRect) {
        let color = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.686)
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 80, height: 80), cornerRadius: 5)
        color.setFill()
        rectanglePath.fill()
        UIColor.whiteColor().setStroke()
        rectanglePath.lineWidth = 3
        rectanglePath.stroke()
    }
 

}
