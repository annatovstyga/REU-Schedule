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
        /*
        // Get lectors list
        InternetManager.sharedInstance.getLectorsList({
            success in
            let groups = success["success"]["data"]
            for item in groups {
                let idLector   = item.1["ID"].int!
                let nameLector = item.1["name"].string!
                let itemLector = LectorItem().initWith(itemID: idLector, itemName: nameLector)
            }
            }, failure:{error in print(error)})
//        */
//        /*
        // Get schedule 
        InternetManager.sharedInstance.getLessonsList(["who":"group","id":195,"timestamp":0], success: {
            success in
            let lessons = success["success"]["data"]
            for item in lessons {
                print(item.1)
//                let arrayGroups = item.1["groups"].array
//                
//                let dayLesson = OneLesson().initWith(hashID: item.1["hash_id"].string!, lessonType: item.1["lesson_type"].string!, room: item.1["room"].string!, groupID: item.1["group_id"].int!, discipline: item.1["discipline"].string!, building: item.1["building"].string!, lector: item.1["lector"].string!, house: item.1["housing"].string!, groups: )
            }
            }, failure: {error in print(error)})
//        */
    }
}