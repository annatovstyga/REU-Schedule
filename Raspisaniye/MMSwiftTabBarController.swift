import UIKit

class MMSwiftTabBarController: UIViewController {
    

    
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
    
    func rotateWeek(sender: UIScreenEdgePanGestureRecognizer) {

        if sender.state == .Ended {
            weekNumber++
            weekLabel.text = "Неделя " + String(weekNumber)

            }
        }


    @IBOutlet weak var weekLabel: UILabel!
    var currentViewController: UIViewController?
    @IBOutlet var placeholderView: UIView!
    
    @IBOutlet var tabBarButtons: Array<UIButton>!
    override func viewDidLoad() {
        let screenEdgeRecognizer: UIScreenEdgePanGestureRecognizer! = UIScreenEdgePanGestureRecognizer(target: self,
            action: "rotateWeek:")
        screenEdgeRecognizer.edges = .Right
        self.view.addGestureRecognizer(screenEdgeRecognizer)
        isLogined = defaults.objectForKey("isLogined") as? Bool ?? Bool()
        let appDelegate = UIApplication.sharedApplication().delegate! as! AppDelegate
        if(isLogined == false)
        {
        let initialViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LoginViewOneControllerID")
        appDelegate.window?.rootViewController = initialViewController
        appDelegate.window?.makeKeyAndVisible()
        }
            performSegueWithIdentifier("mainSegue", sender: tabBarButtons[0])
             weekLabel.text = "Неделя " + String(weekNumber)
            super.viewDidLoad()
    }
    
    
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let availableIdentifiers = ["mainSegue"]
        if(availableIdentifiers.contains(segue.identifier!) ) {
                        
            for btn in tabBarButtons {
                btn.backgroundColor = GlobalColors.lightBlueColor
            }
            
            let senderBtn = sender as! UIButton
               senderBtn.backgroundColor = GlobalColors.BlueColor
            
        }
    }
    
    
    @IBAction func unwindToMMSwiftTabBar(sender: UIStoryboardSegue)
    {
        
        // Pull any data from the view controller which initiated the unwind segue.
    }


}