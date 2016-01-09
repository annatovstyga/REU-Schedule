

import UIKit

class MMSwiftTabBarController: UIViewController {
    
    @IBAction func monClick(sender: AnyObject) {
        performSegueWithIdentifier("mainSegue", sender: tabBarButtons[1])
    }
    @IBAction func TueClick(sender: AnyObject) {
        performSegueWithIdentifier("mainSegue", sender: tabBarButtons[0])
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
    @IBAction func SunClick(sender: AnyObject) {
        performSegueWithIdentifier("mainSegue", sender: tabBarButtons[6])
    }
    
    let firstReuColor = UIColor(red: 212/255, green: 190/255, blue: 106/255, alpha: 1.0)
    let secondReuColor = UIColor(red: 170/255,green: 143/255,blue: 57/255,alpha: 1.0)

    var currentViewController: UIViewController?
    @IBOutlet var placeholderView: UIView!
    @IBOutlet var tabBarButtons: Array<UIButton>!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if(tabBarButtons.count > 0) {
            performSegueWithIdentifier("mainSegue", sender: tabBarButtons[1])
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let availableIdentifiers = ["mainSegue"]
        
        if(availableIdentifiers.contains(segue.identifier!) ) {
                        
            for btn in tabBarButtons {
                btn.selected = false
                btn.backgroundColor = secondReuColor
            }
            
            let senderBtn = sender as! UIButton
               senderBtn.selected = true
               senderBtn.backgroundColor = firstReuColor
            
        }
    }

}