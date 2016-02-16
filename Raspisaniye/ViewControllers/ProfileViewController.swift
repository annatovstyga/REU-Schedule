//
//  ProfileViewController.swift
//  Raspisaniye
//
//  Created by Ilya Mudriy on 13.02.16.
//  Copyright © 2016 rGradeStd. All rights reserved.
//

class ProfileViewController: UIViewController {

    override func viewDidLoad() {

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