import UIKit

class MMSwiftTabBarController: UIViewController {
    
    // MARK: Propiertes
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet var placeholderView: UIView!
    @IBOutlet var tabBarButtons: Array<UIButton>!
    var currentViewController: UIViewController?
    var weekNumberTab:Int? = 1
    @IBOutlet weak var subjectNameLabel: UILabel!
    var currentWeek: Int = 0
    var week: OneWeek = OneWeek()
    var day:  OneDay  = OneDay()
    var lesson: OneLesson = OneLesson()
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
        
        self.updateScheduleProperties()
//        performSegueWithIdentifier("mainSegue", sender: tabBarButtons[0])
        weekNumber = getWeekNumber()
        weekLabel.text = "Неделя " + String(weekNumberTab!)
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
            print(totalSchedule.count)
            if(weekNumberTab < totalSchedule.count)
            {
                (weekNumberTab!)++
                self.updateScheduleProperties()
                weekLabel.text = "Неделя " + String(weekNumberTab!)
                performSegueWithIdentifier("weekSegue", sender: sender)
            }
        }
    }
    
//     MARK: - Update schedule
        func updateScheduleProperties() {
//            if (totalSchedule.count != 0) {
                for item in totalSchedule {
                    if let week = item[weekNumberTab!] {
                        print("week.days - \(week.description())")
                        if let days = week.days {
                            self.day = days[selectedDay]
//                        for day in days {
//                            self.day = day
                            if let lessons = self.day.lessons {
                                for lesson in lessons {
                                    self.lesson = lesson
                                    print("lesson \(self.lesson.description())")
    //                                break
//                                }
                            }
                        }
                    }
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
            
            let dayVC = segue.destinationViewController as! MainTableViewController
            print(self.day.lessons?.count)
            dayVC.day = self.day
        }
    }
    
    
    @IBAction func unwindToMMSwiftTabBar(sender: UIStoryboardSegue)
    {
        
        // Pull any data from the view controller which initiated the unwind segue.
    }
    
    
}