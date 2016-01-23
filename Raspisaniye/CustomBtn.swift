//
//  CustomBtn.swift
//  Raspisaniye
//
//  Created by rGradeStd on 1/23/16.
//  Copyright © 2016 rGradeStd. All rights reserved.
//

import UIKit
@IBDesignable
class CustomBtn: UIButton {
    @IBInspectable var isFilled : Bool = false



    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(rect: rect)
        UIColor.whiteColor().set()
        if(isFilled) //isFilled
        {
        path.fill()
        }
        else
        {
        path.stroke()
        }
        // Drawing code
    }

}
