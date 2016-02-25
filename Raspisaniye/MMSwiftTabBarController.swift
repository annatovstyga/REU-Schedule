import UIKit

class MMSwiftTabBarController: UIViewController {
    
    // MARK: Propiertes
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet var placeholderView: UIView!
    @IBOutlet var tabBarButtons: Array<UIButton>!
    var currentViewController: UIViewController?
    var weekNumberTab:Int? = 1
    var weekNumber:Int? = 1
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
        else{
            if(totalSchedule.count > 0)
            {
             self.updateScheduleProperties(0)
            performSegueWithIdentifier("mainSegue", sender: tabBarButtons[0])
            }
        }
        
       
        weekNumber = getWeekNumber()
        weekLabel.text = "Неделя " + String(weekNumberTab!)
//            subjectName = (subjectIDMemory, subjectNameMemory)

        subjectNameLabel.text = subjectName.1
//        print(subjectNameMemory)
        super.viewDidLoad()
        
        
    }
    
    // MARK: IBActions - buttons
    @IBAction func profileClick(sender: AnyObject) {

        performSegueWithIdentifier("profileSegue", sender: sender)
    }
    @IBAction func monClick(sender: AnyObject) {
        updateScheduleProperties(0)
//        updateScheduleProperties(0)
        performSegueWithIdentifier("mainSegue", sender: tabBarButtons[0])
    }
    @IBAction func TueClick(sender: AnyObject) {
//        updateScheduleProperties(1)
        updateScheduleProperties(4)
        performSegueWithIdentifier("mainSegue", sender: tabBarButtons[1])
    }
    @IBAction func WedClick(sender: AnyObject) {
//        updateScheduleProperties(2)
        updateScheduleProperties(3)
        performSegueWithIdentifier("mainSegue", sender: tabBarButtons[2])
    }
    @IBAction func ThuClick(sender: AnyObject) {
//        updateScheduleProperties(3)
        updateScheduleProperties(5)
        performSegueWithIdentifier("mainSegue", sender: tabBarButtons[3])
    }
    @IBAction func FriClick(sender: AnyObject) {
//        updateScheduleProperties(4)
        updateScheduleProperties(2)
        performSegueWithIdentifier("mainSegue", sender: tabBarButtons[4])
    }
    @IBAction func SutClick(sender: AnyObject) {
//        updateScheduleProperties(5)
        updateScheduleProperties(1)
        performSegueWithIdentifier("mainSegue", sender: tabBarButtons[5])
    }
    
    // MARK: Rotate weeks
    func rotateWeekForward(sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .Ended
        {
//            print(totalSchedule.count)
            if(weekNumberTab < totalSchedule.count)
            {
                (weekNumberTab!)++
                self.updateScheduleProperties(0)
                
                weekLabel.text = "Неделя " + String(weekNumber!)
                performSegueWithIdentifier("weekSegue", sender: sender)
            }
        }
    }
    
//     MARK: - Update schedule
    func updateScheduleProperties(dayIndex:Int?) {
//            if (totalSchedule.count != 0) {
//        print(totalSchedule[0])

    

        
        print(totalSchedule[weekNumberTab! - 1].number)
        weekNumber = totalSchedule[weekNumberTab! - 1].number
        day = (totalSchedule[weekNumberTab! - 1].days![dayIndex!])
        day.lessons?.sortInPlace(beforeLes)
//        print(day.dayName)
//                for item in totalSchedule {
//                    if let week = item[weekNumberTab!] {
//                        print("week.days - \(week.description())")
//                        if let days = week.days {
//                            self.day = days[selectedDay]
////                        for day in days {
////                            self.day = day
//                            if let lessons = self.day.lessons {
//                                for lesson in lessons {
//                                    self.lesson = lesson
//                                    print("lesson \(self.lesson.description())")
//    //                                break
////                                }
//                            }
//                        }
//                    }
//                }
//            }
        }

    
    func rotateWeekBackward(sender: UIScreenEdgePanGestureRecognizer) {
        
        if sender.state == .Ended {
            if(weekNumberTab > 1)
            {
                (weekNumberTab!)--
                weekLabel.text = "Неделя " + String(weekNumber!)
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
        if(segue.identifier! == "mainSegue" ) {
            
            for btn in tabBarButtons {
                btn.backgroundColor = GlobalColors.lightBlueColor
            }
            
            let senderBtn = sender as! UIButton
            senderBtn.backgroundColor = GlobalColors.BlueColor
            
            let dayVC = segue.destinationViewController as! MainTableViewController
            //            print(self.day.lessons?.count)
            dayVC.day = self.day

        }
        if(segue.identifier! == "weekSegue")
        {
            let dayVC = segue.destinationViewController as! MainTableViewController
            //            print(self.day.lessons?.count)
            dayVC.day = self.day
        }
    }
    
    
    
    @IBAction func unwindToMMSwiftTabBar(sender: UIStoryboardSegue)
    {
        
        // Pull any data from the view controller which initiated the unwind segue.
    }
    
    
}