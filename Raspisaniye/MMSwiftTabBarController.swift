import UIKit
import SwiftyJSON

class MMSwiftTabBarController: UIViewController,UITextFieldDelegate{
    
    // MARK: Propiertes
    
    @IBOutlet weak var tabBarView: UIView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet var placeholderView: UIView!
    @IBOutlet var tabBarButtons: Array<UIButton>!
    var currentViewController: UIViewController?
    @IBOutlet weak var subjectNameLabel: UILabel!
    
    @IBOutlet weak var leftWeekArrow: UILabel!
    @IBOutlet weak var rightWeekArrow: UILabel!
    @IBOutlet weak var searchField: AutocompleteField!
    
    var todayDay = getDayOfWeek()!
    var SundayExtended:Bool? = false
    var tabBarFixedIndex:Int? = 1
    var weekNumberTab:Int? = 1
    var selectedDay:Int? = getDayOfWeek()!
    var week: OneWeek = OneWeek()
    var day:  OneDay  = OneDay()
    var lesson: OneLesson = OneLesson()
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func searchClick(sender: AnyObject) {
        if(onSearch == false)
        {
        self.subjectNameLabel.hidden = true
        self.weekLabel.hidden = true
        self.searchField.hidden = false
        self.leftWeekArrow.hidden = true
        self.rightWeekArrow.hidden = true
        InternetManager.sharedInstance.getLectorsList({
            success in
            let groups = success["success"]["data"]
            
            for item in groups {
                let idLector   = item.1["ID"].int!
                let nameLector = item.1["name"].string!
                lectorsNamesList[nameLector] = idLector
                
            }
            for (value, _) in lectorsNamesList {
                lectorsArray.append(value)
            }
            lectorsArray.sortInPlace(before)
            InternetManager.sharedInstance.getGroupList({
                success in
                let groups = success["success"]["data"]
                for item in groups {
                    let idGroup   = item.1["ID"].int!
                    let nameGroup = item.1["name"].string!
                    groupNamesList[nameGroup] = idGroup
                }
                for (value, _) in groupNamesList {
                    groupsArray.append(value)
                }
                groupsArray.sortInPlace(before)
                self.searchField.suggestions = groupsArray + lectorsArray
                }, failure:{error in print(error)
                    //                self.showWarning()
            })
            }, failure:{error in print(error)
//                self.showWarning()
        })
        
        searchField.suggestions = groupsArray + lectorsArray
        onSearch = true
        }
        else{
            self.leftWeekArrow.hidden = false
            self.rightWeekArrow.hidden = false
            searchField.hidden = true
            self.subjectNameLabel.hidden = false
            self.weekLabel.hidden = false
            onSearch = false
        }
    }
    func updateNotificationSentLabel() {
     
    }
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
       self.modalTransitionStyle = .PartialCurl
        dispatch_async(dispatch_get_main_queue(), {
            InternetManager.sharedInstance.getTimestamp({
                success in
//                self.updateAlert()
                
                }, failure:{error in print(error)
            })

            })
        if(weekNumberTab == totalSchedule.count )
        {
            leftWeekArrow.hidden = true
        }
        else if(weekNumberTab == 1)
        {
            rightWeekArrow.hidden = true
        }
        if(sevenDayWeek == false && self.todayDay == 6)
        {
            self.todayDay = 1
        }
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.searchField.delegate = self;
        self.tabBarButtons.last?.imageView?.frame.size.height = self.tabBarView.frame.height / 2
        self.searchField.autocorrectionType = .No
        self.searchField.autocompleteType = .Sentence
        let jsonstring = defaults.valueForKey("jsonData") as? String ?? String()
        jsonDataList = JSON.parse(jsonstring)
        self.navigationItem.title = " "
        self.navigationController?.navigationItem.backBarButtonItem?.tintColor = UIColor.whiteColor()
        dispatch_async(dispatch_get_main_queue(), {
            parse(jsonDataList!,successBlock:
                {
                    successBlock in
                    if(sevenDayWeek == false)
                    {
                        for index in self.tabBarButtons.indices
                        {
                        
                            var xMult:CGFloat?=0
                            switch(index)
                            {
                                case 0:
                                xMult = 0
                                break
                                case 1:
                                xMult = 5
                                break
                                case 2:
                                xMult = 4
                                break
                                case 3:
                                xMult = 2
                                break
                                case 4:
                                xMult = 1
                                break
                                case 5:
                                xMult = 3
                                break
                                case 6:
                                xMult = 6
                                break
                                default:
                                xMult = 0
                            }
                            self.tabBarButtons[index].frame.origin.x = (self.tabBarView.frame.width/6)*(xMult)!
                            self.tabBarButtons[index].frame.size.width = self.tabBarView.frame.width / 6

                        }
                    }
                    else{
                        self.tabBarButtons[6].hidden = false
                    }
                    totalSchedule = successBlock
                    let screenForwardEdgeRecognizer: UISwipeGestureRecognizer! = UISwipeGestureRecognizer(target: self, action: #selector(MMSwiftTabBarController.rotateWeekForward(_:)))
                    screenForwardEdgeRecognizer.direction = .Left
                    let screenBackwardEdgeRecognizer: UISwipeGestureRecognizer! = UISwipeGestureRecognizer(target: self, action: #selector(MMSwiftTabBarController.rotateWeekBackward(_:)))
                    screenBackwardEdgeRecognizer.direction = .Right
                    self.view.addGestureRecognizer(screenForwardEdgeRecognizer)
                    self.view.addGestureRecognizer(screenBackwardEdgeRecognizer)
                    
                    isLogined = defaults.objectForKey("isLogined") as? Bool ?? Bool()
                    
                    
                    if(isLogined ==  false) {
                        let appDelegate = UIApplication.sharedApplication().delegate! as! AppDelegate
                        let initialViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LoginViewOneControllerID")
                        appDelegate.window?.rootViewController = initialViewController
                        appDelegate.window?.makeKeyAndVisible()
                    }
                    else{
                        
                        if(totalSchedule.count > 0)
                        {
                            self.weekNumberTab = getWeekNumber()
                            weekNumber = totalSchedule[self.weekNumberTab! - 1].number!
                            
                            self.weekLabel.text = "Неделя \(String(weekNumber))"
                            
                            self.subjectNameLabel.text = defaults.valueForKey("subjectName") as? String ?? ""
                            self.updateScheduleProperties(self.todayDay)
                            if(self.weekNumberTab == 2)
                            {
                                self.leftWeekArrow.hidden = true
                            }
                            else
                            {
                                 self.rightWeekArrow.hidden = false
                            }
                            if(self.weekNumberTab == totalSchedule.count)
                            {
                                self.rightWeekArrow.hidden = true
                            }
                            else{
                                self.leftWeekArrow.hidden = false
                            }
                            if(self.day.lessons?.count != 0){
                       
                                    self.performSegueWithIdentifier("mainSegue", sender: self.tabBarButtons[self.todayDay])
                                  
                                
                            }
                            else
                            {
                                self.performSegueWithIdentifier("voidLessons", sender: self.tabBarButtons[self.todayDay])
                            }

                        }
                        
                    }
            })
            
        })
        super.viewDidLoad()
        
        
    }
    
    // MARK: IBActions - buttons
    
   
    @IBAction func profileClick(sender: AnyObject) {
        if(searchDisplayed){
            let jsonstring = defaults.valueForKey("jsonData") as? String ?? String()
            jsonDataList = JSON.parse(jsonstring)
            dispatch_async(dispatch_get_main_queue(), {
                parse(jsonDataList!,successBlock:
                    {
                        successBlock in
                        totalSchedule = successBlock
                            
                            if(totalSchedule.count > 0)
                            {
                                self.weekNumberTab = getWeekNumber()
                                weekNumber = totalSchedule[self.weekNumberTab! - 1].number!
                                
                                
                                self.subjectNameLabel.text = defaults.valueForKey("subjectName") as? String ?? ""
                                self.updateScheduleProperties(self.todayDay)
                                if(self.weekNumberTab == totalSchedule.count )
                                {
                                    self.leftWeekArrow.hidden = true
                                }
                                else if(self.weekNumberTab == 1)
                                {
                                    self.rightWeekArrow.hidden = true
                                }

                                if(self.day.lessons?.count != 0){
                                    self.performSegueWithIdentifier("mainSegue", sender: self.tabBarButtons[self.todayDay])
                                }
                                else
                                {
                                    self.performSegueWithIdentifier("voidLessons", sender: self.tabBarButtons[self.todayDay])
                                }
                                
                            }
                            
                        
                })
                
            })
            searchDisplayed = false
            self.leftButton.setTitle("", forState: .Normal)
            self.leftButton.setImage(UIImage(named: "Person"), forState: .Normal)
        }
        else{
            performSegueWithIdentifier("profileSegue", sender: sender)
        }
    }
    
    @IBAction func SunExtend(sender: AnyObject) {
        if(SundayExtended != true)
        {
            SundayExtension()
            tabBarButtons.last?.setTitle("Вс", forState: .Normal)
        }
        updateScheduleProperties(6)
        selectedDay = 6
        print(self.day.lessons?.count)
        if(self.day.lessons?.count != 0){
            performSegueWithIdentifier("mainSegue", sender: tabBarButtons[6])
        }
        else
        {
            performSegueWithIdentifier("voidLessons", sender: tabBarButtons[6])
        }


    }
    
    func SundayExtension()
    {
        
        var count:CGFloat = 0;
        for btn in tabBarButtons
        {
            
            
            btn.frame.origin.x = (tabBarView.frame.width/7)*(count)
            btn.frame.size.width = tabBarView.frame.width / 7
            count++
        }
        SundayExtended = true
    }
   
    @IBAction func monClick(sender: AnyObject) {
        updateScheduleProperties(0)
        selectedDay = 0
        if(self.day.lessons?.count != 0){
            performSegueWithIdentifier("mainSegue", sender: tabBarButtons[selectedDay!])
        }
        else
        {
            performSegueWithIdentifier("voidLessons", sender: tabBarButtons[selectedDay!])
        }
    }
    @IBAction func TueClick(sender: AnyObject) {

        updateScheduleProperties(4)
        selectedDay = 4
        if(self.day.lessons?.count != 0){
            performSegueWithIdentifier("mainSegue", sender: tabBarButtons[selectedDay!])
        }
        else
        {
            
            performSegueWithIdentifier("voidLessons", sender: tabBarButtons[selectedDay!])
        }
    }
    @IBAction func WedClick(sender: AnyObject) {

        updateScheduleProperties(3)
        selectedDay = 3
        if(self.day.lessons?.count != 0){
       
            performSegueWithIdentifier("mainSegue", sender: tabBarButtons[selectedDay!])
        }
        else
        {
            performSegueWithIdentifier("voidLessons", sender: tabBarButtons[selectedDay!])
        }
    }
    @IBAction func ThuClick(sender: AnyObject) {

        updateScheduleProperties(5)
        selectedDay = 5
        if(self.day.lessons?.count != 0){
         
            performSegueWithIdentifier("mainSegue", sender: tabBarButtons[selectedDay!])
        }
        else
        {
            performSegueWithIdentifier("voidLessons", sender: tabBarButtons[selectedDay!])
        }
    }
    @IBAction func FriClick(sender: AnyObject) {

        updateScheduleProperties(2)
        selectedDay = 2
        
        if(self.day.lessons?.count != 0){
            selectedDay = 2
            performSegueWithIdentifier("mainSegue", sender: tabBarButtons[selectedDay!])
        }
        else
        {
            performSegueWithIdentifier("voidLessons", sender: tabBarButtons[selectedDay!])
        }
    }
    @IBAction func SutClick(sender: AnyObject) {

        updateScheduleProperties(1)
        selectedDay = 1
        if(self.day.lessons?.count != 0){
            selectedDay = 1
            performSegueWithIdentifier("mainSegue", sender: tabBarButtons[selectedDay!])
        }
        else
        {
            performSegueWithIdentifier("voidLessons", sender: tabBarButtons[selectedDay!])
        }
    }
    
    // MARK: Rotate weeks
    
    func rotateWeekForward(sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .Ended
        {
            if(weekNumberTab < totalSchedule.count)
            {
                segueSide = 1
                (weekNumberTab!) += 1
                self.updateScheduleProperties(selectedDay)
                weekLabel.text = "Неделя " + String(weekNumber)
                if(day.date != ""){
                    weekLabel.text? += ", \(day.date!)"
                }
                arrowPing(rightWeekArrow)
                if(weekNumberTab == totalSchedule.count )
                {
                    rightWeekArrow.hidden = true
                }
                else
                {
                    leftWeekArrow.hidden = false
                }
                if(self.day.lessons?.count != 0){
                    performSegueWithIdentifier("weekSegue", sender: tabBarButtons[selectedDay!])
                }
                else
                {
                    performSegueWithIdentifier("voidLessons", sender: tabBarButtons[selectedDay!])
                }

            }
        }
    }
    
    func rotateWeekBackward(sender: UIScreenEdgePanGestureRecognizer) {
        
        if sender.state == .Ended {
            if(weekNumberTab > 1)
            {
                if(weekNumberTab == 2)
                {
                    leftWeekArrow.hidden = true
                }
                else
                {
                    rightWeekArrow.hidden = false
                }
                segueSide = -1
                (weekNumberTab!) -= 1
                arrowPing(leftWeekArrow)
                self.updateScheduleProperties(selectedDay)
                
                weekLabel.text = "Неделя " + String(weekNumber)
                if(day.date != ""){
                    weekLabel.text? += ", \(day.date!)"
                }
                if(self.day.lessons?.count != 0){
                    performSegueWithIdentifier("weekSegue", sender: tabBarButtons[selectedDay!])
                }
                else
                {
                    performSegueWithIdentifier("voidLessons", sender: tabBarButtons[selectedDay!])
                }

                
            }
            
        }
    }
    func arrowPing(label:UILabel?) {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = NSNumber(float: 1.7)
        animation.duration = 0.3
        animation.repeatCount = 1.0
        animation.autoreverses = true
        label!.layer.addAnimation(animation, forKey: nil)
    }
//     MARK: - Update schedule
    func updateScheduleProperties(dayIndex:Int?) {


        weekNumber = totalSchedule[weekNumberTab! - 1].number!
        if(dayIndex < totalSchedule[weekNumberTab! - 1].days?.count)
        {
            day = (totalSchedule[weekNumberTab! - 1].days![dayIndex!])
        }
        else
        {
            day = OneDay()
        }
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
            weekLabel.text = "Неделя " + String(weekNumber)
            if(day.date != ""){
                weekLabel.text? += ", \(day.date!)"
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
            weekLabel.text = "Неделя " + String(weekNumber)
            if(day.date != ""){
                weekLabel.text? += ", \(day.date!)"
            }
            let senderBtn = sender as! UIButton
            senderBtn.backgroundColor = GlobalColors.BlueColor
            
        }
        if(segue.identifier! == "weekSegue")
        {
            
            for btn in tabBarButtons {
                btn.backgroundColor = GlobalColors.lightBlueColor
            }
            
            let senderBtn = sender as! UIButton
            senderBtn.backgroundColor = GlobalColors.BlueColor
            let dayVC = segue.destinationViewController as! MainTableViewController
            dayVC.day = self.day

        }
        
    }
    
    func showWarning() {
        let alertController = UIAlertController(title: "Некоректный ввод!", message:
            "Попробуйте ввести название группы правильно", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    func updateAlert() {
        let alertController = UIAlertController(title: "Доступно обновление расписания!", message:
            "Загрузить обновленное расписание?", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Да", style: UIAlertActionStyle.Default,handler: nil))
        alertController.addAction(UIAlertAction(title: "Отменить", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Text field delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
            let NameTemp = searchField.suggestionNormal
            var indexTemp = groupNamesList[NameTemp]
            var tempAMIS:Bool  = true
            if(indexTemp == nil)
            {
                indexTemp = lectorsNamesList[NameTemp]
                if(indexTemp != nil){
                    tempAMIS = false
                }
            }
            if(indexTemp != nil){
                amistudent = tempAMIS
                subjectName = (indexTemp!, NameTemp)
                self.enter()
            }
            else{
                self.showWarning()
            }
        
        self.leftButton.setImage(nil, forState: .Normal)
        self.leftButton.setImage(UIImage(named: "Arrow"), forState: .Normal)
        onSearch = false
        searchDisplayed = true
        return false
    }
    
    func updateSchedule(itemID itemID: Int, successBlock: Void -> ()) {
        var Who:String = "lector"
        if(amistudent)
        {
            Who = "group"
        }
        InternetManager.sharedInstance.getLessonsList(["who":Who,"id":itemID,"timestamp":0], success: {
            success in
            jsonDataList = success
            successBlock()
            }, failure: {error in print(error)})
    }

    func enter()
    {
        
        dispatch_async(dispatch_get_main_queue(), {
            self.updateSchedule(itemID: subjectName.0, successBlock: {
                successBlock in
                dispatch_async(dispatch_get_main_queue(), {
                    parse(jsonDataList!,successBlock:
                        {
                            successBlock in
                            totalSchedule = successBlock
                            
                            
                                if(totalSchedule.count > 0)
                                {
                                    self.weekNumberTab = getWeekNumber()
                                    weekNumber = totalSchedule[self.weekNumberTab! - 1].number!
                                    
                                    self.weekLabel.text = "Неделя " + String(weekNumber)
                                    if(self.day.date != ""){
                                        self.weekLabel.text? += ", \(self.day.date!)"
                                    }
                                    
                                    self.subjectNameLabel.text = subjectName.1
                                    self.updateScheduleProperties(0)
                                    self.weekLabel.hidden = false
                                    self.searchField.hidden = true
                                    self.subjectNameLabel.hidden = false
                                    if(self.day.lessons?.count != 0){
                                        self.performSegueWithIdentifier("mainSegue", sender: self.tabBarButtons[self.selectedDay!])
                                    }
                                    else
                                    {
                                        self.performSegueWithIdentifier("voidLessons", sender: self.tabBarButtons[self.selectedDay!])
                                    }
                            }
                    })
                    
                })
            })
        })
    }
}