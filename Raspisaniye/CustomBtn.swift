import UIKit



@IBDesignable
class CustomBtn: UIButton {
    
    @IBInspectable var isFilled : Bool = false
    @IBInspectable var btnColor: UIColor = UIColor.whiteColor()
    
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
    }
}