//
//  TestViewController.swift
//  Raspisaniye
//
//  Created by Ilya Mudriy on 09.02.16.
//  Copyright © 2016 rGradeStd. All rights reserved.
//
import SwiftyJSON

class TestViewController: UIViewController {
    
    @IBAction func testButton(sender: UIButton) {
        /*
        // Get groups list
        InternetManager.sharedInstance.getGroupList({
            success in
            let groups = success["success"]["data"]
            for item in groups {
                print(item.1["name"])
            }
            }, failure:{error in print(error)})
        */
        /*
        // Get lectors list
        InternetManager.sharedInstance.getLectorsList({
            success in
            let groups = success["success"]["data"]
            for item in groups {
                print(item.1["name"])
            }
            }, failure:{error in print(error)})
        */
        
        // Get schedule 
        InternetManager.sharedInstance.getLessonsList(["who":"group","id":143,"timestamp":0], success: {
            success in
            let lessons = success["success"]["data"]
            for item in lessons {
                print(item)
            }
            }, failure: {error in print(error)})
        
    }
}