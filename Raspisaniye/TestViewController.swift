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
            
            // Data is item of week
            for data in success["success"]["data"] {
                var week = OneWeek()

                for weekData in data.1 {
                   
                    var day = OneDay()
                    for dayData in weekData.1
                    {
                        if(dayData.1 != nil)
                        {
                        for item in dayData.1{
                            
                            if(item.1 != nil){
                                let lectorName:String?
                                
                                if(item.1["lector"].string != nil)
                                {
                                    lectorName = item.1["lector"].string
                                }
                                else
                                {
                                    lectorName = ""
                                }
                            
//                                let dayLesson = OneLesson().initWith(hashID: item.1["hash_id"].string!, lessonTypeValue: item.1["lesson_type"].string!, roomValue: item.1["room"].int!, disciplineValue: item.1["discipline"].string!, buildingValue: item.1["building"].string!, lectorValue: lectorName!, houseValue: item.1["housing"].int!)
                                
//                                    day.Lessons.append(dayLesson)
                                }
                          
                            }
                            let string:String = dayData.0
//                            day.Number = getDayNumber(string)
                            }
//                            week.Days.append(day)
//                            print(week.Days[0].Lessons)
                        }
                }

            }
            }, failure: {error in print(error)})
//        */
    }
}