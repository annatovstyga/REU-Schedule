import UIKit

class WeekNavigationSegue: UIStoryboardSegue {
    
    override func perform() {
        
        let tabBarController = self.sourceViewController as! MMSwiftTabBarController
        let destinationController = self.destinationViewController as UIViewController
        
        for view in tabBarController.placeholderView.subviews as [UIView] {
            view.removeFromSuperview()
        }
        
        
        tabBarController.currentViewController = destinationController
        tabBarController.placeholderView.addSubview(destinationController.view)
        
        
        tabBarController.placeholderView.translatesAutoresizingMaskIntoConstraints = false
        destinationController.view.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[v1]-0-|", options: .AlignAllTop, metrics: nil, views: ["v1": destinationController.view])
        
        tabBarController.placeholderView.addConstraints(horizontalConstraint)
        
        let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[v1]-0-|", options: .AlignAllTop, metrics: nil, views: ["v1": destinationController.view])
        
        tabBarController.placeholderView.addConstraints(verticalConstraint)
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            destinationController.view.transform = CGAffineTransformScale(destinationController.view.transform, 0.5, 0.5)
            //            tabBarController.view.frame = CGRectOffset(tabBarController.view.frame, 0.0, -screenHeight)
            
            }) { (Finished) -> Void in
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    destinationController.view.transform = CGAffineTransformIdentity
                    
                    }, completion: { (Finished) -> Void in
                        
                        
                })
                //                self.sourceViewController.presentViewController(self.destinationViewController as UIViewController,
                //                    animated: false,
                //                    completion: nil)
        }
        
        tabBarController.placeholderView.layoutIfNeeded()
        destinationController.didMoveToParentViewController(tabBarController)
        
        
    }
    
}
