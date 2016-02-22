//
//  ProfileViewController.swift
//  Raspisaniye
//
//  Created by Ilya Mudriy on 13.02.16.
//  Copyright © 2016 rGradeStd. All rights reserved.
//

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var subjectNameLabel: UILabel!
    @IBAction func changeTheSubject(sender: AnyObject) {
        defaults.setBool(false, forKey: "isLogined")
        if let vc = storyboard?.instantiateViewControllerWithIdentifier("LoginViewOneControllerID") as? LoginViewOneController {
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    @IBOutlet weak var weekNumberLabel: UILabel!
    override func viewDidLoad() {
        if(isLogined == true) {
            subjectName = (subjectIDMemory, subjectNameMemory)
        }
        self.subjectNameLabel.text = subjectName.1
        self.weekNumberLabel.text = String(weekNumber) + " неделя"
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
}