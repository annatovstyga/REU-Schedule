import UIKit
import SwiftyJSON

class MMSwiftTabBarController: UIViewController {
    
    // MARK: Propiertes
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet var placeholderView: UIView!
    @IBOutlet var tabBarButtons: Array<UIButton>!
    var currentViewController: UIViewController?
    @IBOutlet weak var subjectNameLabel: UILabel!
    
    var weekNumberTab:Int? = 1

    var week: OneWeek = OneWeek()
    var day:  OneDay  = OneDay()
    var lesson: OneLesson = OneLesson()
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let jsonstring = defaults.valueForKey("jsonData") as? String ?? String()
        jsonDataList = JSON.parse(jsonstring)
        
        dispatch_async(dispatch_get_main_queue(), {
            parse(jsonDataList!,successBlock:
                {
                    successBlock in
                    totalSchedule = successBlock
                    
                    let screenForwardEdgeRecognizer: UIScreenEdgePanGestureRecognizer! = UIScreenEdgePanGestureRecognizer(target: self,
                        action: "rotateWeekForward:")
                    let screenBackwardEdgeRecognizer: UIScreenEdgePanGestureRecognizer! = UIScreenEdgePanGestureRecognizer(target: self,
                        action: "rotateWeekBackward:")
                    screenForwardEdgeRecognizer.edges = .Right
                    screenBackwardEdgeRecognizer.edges = .Left
                    self.view.addGestureRecognizer(screenForwardEdgeRecognizer)
                    self.view.addGestureRecognizer(screenBackwardEdgeRecognizer)
                    
                    isLogined = defaults.objectForKey("isLogined") as? Bool ?? Bool()
                    
                    
                    if(isLogined ==  false) { // debuging
                        let appDelegate = UIApplication.sharedApplication().delegate! as! AppDelegate
                        let initialViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LoginViewOneControllerID")
                        appDelegate.window?.rootViewController = initialViewController
                        appDelegate.window?.makeKeyAndVisible()
                    }
                    else{
                        
                        if(totalSchedule.count > 0)
                        {
                            self.weekNumberTab = getWeekNumber()
                            print("NUMBER - \(self.weekNumberTab!)")
                            weekNumber = totalSchedule[self.weekNumberTab! - 1].number!
                            
                            self.weekLabel.text = "Неделя \(String(weekNumber))"
                            
                            self.subjectNameLabel.text = defaults.valueForKey("subjectName") as? String ?? ""
                            self.updateScheduleProperties(0)
                            if(self.day.lessons?.count != 0){
                             self.performSegueWithIdentifier("mainSegue", sender: self.tabBarButtons[0])
                            }
                            else
                            {
                                self.performSegueWithIdentifier("voidLessons", sender: self.tabBarButtons[0])
                            }

                        }
                        
                    }
            })
            
        })
        
        
    }
    
    // MARK: IBActions - buttons
    
    @IBAction func searchClick(sender: AnyObject) {
        performSegueWithIdentifier("search", sender: sender)
    }
    @IBAction func profileClick(sender: AnyObject) {
        
        performSegueWithIdentifier("profileSegue", sender: sender)
    }
    @IBAction func monClick(sender: AnyObject) {
        updateScheduleProperties(0)
        if(self.day.lessons?.count != 0){
        performSegueWithIdentifier("mainSegue", sender: tabBarButtons[0])
        }
        else
        {
            performSegueWithIdentifier("voidLessons", sender: tabBarButtons[0])
        }
    }
    @IBAction func TueClick(sender: AnyObject) {

        updateScheduleProperties(4)
        if(self.day.lessons?.count != 0){
            performSegueWithIdentifier("mainSegue", sender: tabBarButtons[1])
        }
        else
        {
            performSegueWithIdentifier("voidLessons", sender: tabBarButtons[1])
        }
    }
    @IBAction func WedClick(sender: AnyObject) {

        updateScheduleProperties(3)
        if(self.day.lessons?.count != 0){
            performSegueWithIdentifier("mainSegue", sender: tabBarButtons[2])
        }
        else
        {
            performSegueWithIdentifier("voidLessons", sender: tabBarButtons[2])
        }
    }
    @IBAction func ThuClick(sender: AnyObject) {

        updateScheduleProperties(5)
        if(self.day.lessons?.count != 0){
            performSegueWithIdentifier("mainSegue", sender: tabBarButtons[3])
        }
        else
        {
            performSegueWithIdentifier("voidLessons", sender: tabBarButtons[3])
        }
    }
    @IBAction func FriClick(sender: AnyObject) {

        updateScheduleProperties(2)
        if(self.day.lessons?.count != 0){
            performSegueWithIdentifier("mainSegue", sender: tabBarButtons[4])
        }
        else
        {
            performSegueWithIdentifier("voidLessons", sender: tabBarButtons[4])
        }
    }
    @IBAction func SutClick(sender: AnyObject) {

        updateScheduleProperties(1)
        if(self.day.lessons?.count != 0){
            performSegueWithIdentifier("mainSegue", sender: tabBarButtons[5])
        }
        else
        {
            performSegueWithIdentifier("voidLessons", sender: tabBarButtons[5])
        }
    }
    
    // MARK: Rotate weeks
    
    func rotateWeekForward(sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .Ended
        {
            if(weekNumberTab < totalSchedule.count)
            {
                (weekNumberTab!)++
                self.updateScheduleProperties(0)
                
                weekLabel.text = "Неделя " + String(weekNumber)
                performSegueWithIdentifier("weekSegue", sender: sender)
            }
        }
    }
    
    func rotateWeekBackward(sender: UIScreenEdgePanGestureRecognizer) {
        
        if sender.state == .Ended {
            if(weekNumberTab > 1)
            {
               
                
                (weekNumberTab!)--
                 self.updateScheduleProperties(0)
                weekLabel.text = "Неделя " + String(weekNumber)
                performSegueWithIdentifier("weekSegue", sender: sender)
            }
            
        }
    }

//     MARK: - Update schedule
    
    func updateScheduleProperties(dayIndex:Int?) {

        print(totalSchedule[weekNumberTab! - 1].number)
        weekNumber = totalSchedule[weekNumberTab! - 1].number!
        day = (totalSchedule[weekNumberTab! - 1].days![dayIndex!])
        day.lessons?.sortInPlace(beforeLes)
        
    }

    
    
    
    // MARK: Supporting methods
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    // MARK: Segue methods
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier! == "mainSegue" ) {
            
            for btn in tabBarButtons {
                btn.backgroundColor = GlobalColors.lightBlueColor
            }
            
            let senderBtn = sender as! UIButton
            senderBtn.backgroundColor = GlobalColors.BlueColor
            
            let dayVC = segue.destinationViewController as! MainTableViewController
            dayVC.day = self.day

        }
        if(segue.identifier! == "voidLessons" )
        {
            
            for btn in tabBarButtons {
                btn.backgroundColor = GlobalColors.lightBlueColor
            }
            
            let senderBtn = sender as! UIButton
            senderBtn.backgroundColor = GlobalColors.BlueColor

        }
        if(segue.identifier! == "weekSegue")
        {
            
            for btn in tabBarButtons {
                btn.backgroundColor = GlobalColors.lightBlueColor
            }
            
            tabBarButtons[0].backgroundColor = GlobalColors.BlueColor
            let dayVC = segue.destinationViewController as! MainTableViewController
            
            dayVC.day = self.day
        }
        
    }
    

    
    @IBAction func unwindToMMSwiftTabBar(sender: UIStoryboardSegue)
    {
        
        // Pull any data from the view controller which initiated the unwind segue.
    }
    
    
}