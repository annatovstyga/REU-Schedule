import UIKit

class MMSwiftTabBarController: UIViewController {
    
    // MARK: Propiertes
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet var placeholderView: UIView!
    @IBOutlet var tabBarButtons: Array<UIButton>!
    var currentViewController: UIViewController?
    var weekNumberTab:Int?
    @IBOutlet weak var subjectNameLabel: UILabel!
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        
        let screenForwardEdgeRecognizer: UIScreenEdgePanGestureRecognizer! = UIScreenEdgePanGestureRecognizer(target: self,
            action: "rotateWeekForward:")
        let screenBackwardEdgeRecognizer: UIScreenEdgePanGestureRecognizer! = UIScreenEdgePanGestureRecognizer(target: self,
            action: "rotateWeekBackward:")
        screenForwardEdgeRecognizer.edges = .Right
        screenBackwardEdgeRecognizer.edges = .Left
        self.view.addGestureRecognizer(screenForwardEdgeRecognizer)
        self.view.addGestureRecognizer(screenBackwardEdgeRecognizer)
        
        isLogined = defaults.objectForKey("isLogined") as? Bool ?? Bool()
        let appDelegate = UIApplication.sharedApplication().delegate! as! AppDelegate
        
        if(isLogined ==  false) { // debuging
            let initialViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LoginViewOneControllerID")
            appDelegate.window?.rootViewController = initialViewController
            appDelegate.window?.makeKeyAndVisible()
        }
        
        
        performSegueWithIdentifier("mainSegue", sender: tabBarButtons[0])
        weekNumber = getWeekNumber()
        weekNumberTab = weekNumber
        weekLabel.text = "Неделя " + String(weekNumber)
        if(isLogined == true) {
            subjectName = (subjectIDMemory, subjectNameMemory)
        }
        subjectNameLabel.text = subjectName.1
        super.viewDidLoad()
        
    }
    
    // MARK: IBActions - buttons
    @IBAction func profileClick(sender: AnyObject) {
        performSegueWithIdentifier("profileSegue", sender: sender)
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
    
    // MARK: Rotate weeks
    func rotateWeekForward(sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .Ended
        {
            if(weekNumberTab < 56)
            {
                (weekNumberTab!)++
                weekLabel.text = "Неделя " + String(weekNumberTab!)
                performSegueWithIdentifier("weekSegue", sender: sender)
            }
        }
    }
    
    func rotateWeekBackward(sender: UIScreenEdgePanGestureRecognizer) {
        
        if sender.state == .Ended {
            if(weekNumberTab > 1)
            {
                (weekNumberTab!)--
                weekLabel.text = "Неделя " + String(weekNumberTab!)
                performSegueWithIdentifier("weekSegue", sender: sender)
            }
            
        }
    }
    
    // MARK: Supporting methods
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    // MARK: Segue methods
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