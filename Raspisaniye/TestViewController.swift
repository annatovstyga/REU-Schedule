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
        
//         Get lectors list
        
      
//        /*
//         Get schedule
        InternetManager.sharedInstance.getLessonsList(["who":"group","id":195,"timestamp":0], success: {
            success in
            for week in success["success"]["data"] {
                for day in week.1 {
                    print(day.1)
                }
                
//                let arrayGroups = item.1["groups"]
//                print("array of groups \(arrayGroups)")
                
//                let dayLesson = OneLesson().initWith(hashID: item.1["hash_id"].string, lessonTypeValue: item.1["lesson_type"].string, roomValue: item.1["room"].string, groupIDValue: item.1["group_id"].int, disciplineValue: item.1["discipline"].string, buildingValue: item.1["building"].string, lectorValue: item.1["lector"].string, houseValue: item.1["housing"].string, groupsValue: arrayGroups)
//                print("lessons at day \(dayLesson)")
            }
            }, failure: {error in print(error)})
//        */
    }
}