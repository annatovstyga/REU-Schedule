import UIKit

class MMSwiftTabBarController: UIViewController {
    
    
    @IBAction func PersonClick(sender: AnyObject) {
         performSegueWithIdentifier("cabSegue", sender: self)
    }
    
    @IBAction func monClick(sender: AnyObject) {
        performSegueWithIdentifier("mainSegue", sender: tabBarButtons[0])
    }
    @IBAction func TueClick(sender: AnyObject) {
        performSegueWithIdentifier("mainSegue", sender: tabBarButtons[1])
    }
    @IBAction func WedClick(sender: AnyObject) {
        performSegueWithIdentifier("mainSegue", sender: tabBarButtons[2])
    }
    @IBAction func ThuClick(sender: AnyObject) {
        performSegueWithIdentifier("mainSegue", sender: tabBarButtons[3])
    }
    @IBAction func FriClick(sender: AnyObject) {
        performSegueWithIdentifier("mainSegue", sender: tabBarButtons[4])
    }

    @IBAction func SutClick(sender: AnyObject) {
         performSegueWithIdentifier("mainSegue", sender: tabBarButtons[5])
    }
    
    

    var currentViewController: UIViewController?
    @IBOutlet var placeholderView: UIView!
    
    @IBOutlet var tabBarButtons: Array<UIButton>!
    @IBOutlet var tabBarButtons2: Array<UIButton>!
    override func viewDidLoad() {
        print(tabBarButtons)
        super.viewDidLoad()
            performSegueWithIdentifier("mainSegue", sender: tabBarButtons[0])
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let availableIdentifiers = ["mainSegue"]
        if(availableIdentifiers.contains(segue.identifier!) ) {
                        
            for btn in tabBarButtons {
                btn.selected = false
                btn.backgroundColor = GlobalColors.secondColor
            }
            
            let senderBtn = sender as! UIButton
               senderBtn.selected = true
               senderBtn.backgroundColor = GlobalColors.firstColor
            
        }
    }

}