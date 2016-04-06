//
//  ProfileViewController.swift
//  Raspisaniye
//
//  Created by Ilya Mudriy on 13.02.16.
//  Copyright © 2016 rGradeStd. All rights reserved.
//

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var subjectNameLabel: UILabel!
    
    @IBOutlet weak var backButton: UINavigationItem!
    @IBAction func changeTheSubject(sender: AnyObject) {
        defaults.setBool(false, forKey: "isLogined")
        if let vc = storyboard?.instantiateViewControllerWithIdentifier("LoginViewOneControllerID") as? LoginViewOneController {
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    @IBOutlet weak var weekNumberLabel: UILabel!
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
                self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.subjectNameLabel.text = defaults.valueForKey("subjectName") as? String ?? ""
        self.weekNumberLabel.text = "\(totalWeekNumber()) неделя"
        
        // Customize navigation bar
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.translucent = false
      
        let backgroundImage = UIImage(named: "profileNavigationBackground@2x")
        self.navigationController?.navigationBar.setBackgroundImage(backgroundImage?.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: UIImageResizingMode.Stretch), forBarMetrics: UIBarMetrics.Default)
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    func totalWeekNumber()->Int
    {
        let start = "2015-09-01"
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let startDate:NSDate = dateFormatter.dateFromString(start)!
        let endDate:NSDate = NSDate()
        
        func daysBetweenDate(startDate: NSDate, endDate: NSDate) -> Int
        {
            let calendar = NSCalendar.currentCalendar()
            
            let components = calendar.components([.Day], fromDate: startDate, toDate: endDate, options: [])
            
            return components.day
        }
        let days = daysBetweenDate(startDate, endDate: endDate) + 1
        let week = days/7 + 1
        return week
    }
}