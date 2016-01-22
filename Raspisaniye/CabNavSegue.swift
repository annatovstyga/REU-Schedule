import UIKit

class CabNavSegue: UIStoryboardSegue {
    
    override func perform() {
        
        let CabBarController = self.sourceViewController as! CabController
        let destinationController = self.destinationViewController as UIViewController
        
        for view in CabBarController .placeholderView.subviews as [UIView] {
            view.removeFromSuperview()
        }
        
        
      CabBarController.currentViewController = destinationController
      CabBarController.placeholderView.addSubview(destinationController.view)
        
        
        CabBarController.placeholderView.translatesAutoresizingMaskIntoConstraints = false
        destinationController.view.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[v1]-0-|", options: .AlignAllTop, metrics: nil, views: ["v1": destinationController.view])
        
        CabBarController.placeholderView.addConstraints(horizontalConstraint)
        
        let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[v1]-0-|", options: .AlignAllTop, metrics: nil, views: ["v1": destinationController.view])
        
        CabBarController.placeholderView.addConstraints(verticalConstraint)
        
        CabBarController.placeholderView.layoutIfNeeded()
        destinationController.didMoveToParentViewController(CabBarController)
        
        
    }
    
}
