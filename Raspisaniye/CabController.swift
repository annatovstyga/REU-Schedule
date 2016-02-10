
import UIKit

class CabController: UIViewController {
    
    
    @IBAction func firstBtnClick(sender: AnyObject) {
         performSegueWithIdentifier("cabTabSegue", sender: tabBarButtons[0])
        
    }
    @IBAction func secondBtnClick(sender: AnyObject) {
    performSegueWithIdentifier("cabTabSegue", sender: tabBarButtons[1])
    }
    
       var currentViewController: UIViewController?
    @IBOutlet var placeholderView: UIView!
    @IBOutlet var tabBarButtons: Array<UIButton>!

    override func viewDidLoad() {
        super.viewDidLoad()
        performSegueWithIdentifier("cabTabSegue", sender: tabBarButtons[0])
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let availableIdentifiers = ["cabTabSegue"]
        if(availableIdentifiers.contains(segue.identifier!) ) {
            
            for btn in tabBarButtons {
//                btn.selected = false //fix it
//                btn.backgroundColor = GlobalColors.secondColor
            }
            
            let senderBtn = sender as! UIButton
//            senderBtn.selected = true //fix it
//            senderBtn.backgroundColor = GlobalColors.firstColor
            
        }
    }
}
