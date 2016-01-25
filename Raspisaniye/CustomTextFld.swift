//
//  CustomTextFld.swift
//  Raspisaniye
//
//  Created by rGradeStd on 1/25/16.
//  Copyright © 2016 rGradeStd. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTextFld: UITextField {
    @IBInspectable var isFilled : Bool = false
    @IBInspectable var btnColor: UIColor = UIColor.whiteColor()
    var placegolderText: String = "Введите "
    override func drawRect(rect: CGRect) {
        
        let path = UIBezierPath(rect: rect)
        btnColor.set()
        
        if(isFilled)
        {
            path.fill()
        }
        else
        {
            path.stroke()
        }
       self.attributedPlaceholder =  NSAttributedString(string:placegolderText,
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
    }
}