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
        let idGroup   = item.1["ID"].int!
        let nameGroup = item.1["name"].string!
        let itemGroup = GroupItem().initWith(itemID: idGroup, itemName: nameGroup)
        }
        }, failure:{error in print(error)})
//        */
        
        // Get schedule
        InternetManager.sharedInstance.getLessonsList(["who":"group","id":195,"timestamp":0], success: {
            success in
            
            // weekData - is JSON item of week
            for weekData in success["success"]["data"] {
//                print("weekData.0 - \(weekData.0)")
//                print("weekData.1 - \(weekData.1)")
                // week - is JSON data of item with Days
                for week in weekData.1 {
//                    print("week.0 - \(week.0)")
//                    print("week.1 - \(week.1)")
                    // dayData - is JSON data of one day
                    for dayData in week.1 {
//                        print("dayData.0 - \(dayData.0)")
//                        print("dayData.1 - \(dayData.1)")
                        if(dayData.1 != nil) {
                            // lessonData - is data of one lesson
                            for lessonData in dayData.1 {
//                                print("item.0 - \(lessonData.0)")
//                                print("item.1 - \(lessonData.1)")
                                if(dayData.1 != nil) {
                                    break
                                }
                            }
                        }
                    }
                }
            }
            }, failure: {error in print(error)})
//        */
    }
}