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
//       let Data =  getDataForGroup("195")


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
        //
        
*/
        //================
        var totalSchedule: [[Int:AnyObject]] = []
        InternetManager.sharedInstance.getLessonsList(["who":"group","id":195,"timestamp":0], success: {
            success in
            // semestr - is JSON item of week
            for semestr in success["success"]["data"] {
                var oneSemDic: [Int:AnyObject] = [:]
                let oneWeek: OneWeek = OneWeek()
                let oneDay: OneDay = OneDay()
                oneWeek.number = semestr.1["weekNum"].int
                oneWeek.days = []
                // weekData - is one week
                for weekData in semestr.1 {
                    // dayData - is one day
                    for dayData in weekData.1 {
                        oneDay.dayName = dayData.0
                        oneDay.lessons = []
                        if(dayData.1 != nil) {
                            // lessonData - is one lesson
                            for lessonData in dayData.1 {
                                if(lessonData.1 != nil) {
                                    // Main properties
                                    let lessonNumber        = Int(lessonData.0)
                                    let hashID: String?     = lessonData.1["hash_id"].string
                                    let lessonType: String? = lessonData.1["lesson_type"].string
                                    let room: String?       = lessonData.1["room"].string
                                    let lessonStart: String? = lessonData.1["lesson_start"].string
                                    let lessonEnd: String?   = lessonData.1["lesson_end"].string
                                    let discipline: String? = lessonData.1["discipline"].string
                                    let building: String?   = lessonData.1["building"].string
                                    let lector: String?     = lessonData.1["lector"].string
                                    let house: Int?         = lessonData.1["housing"].int
                                    // Groups property
                                    var groups: [String]?   = []
                                    let lessonsGroups = lessonData.1["groups"].array
                                    if let data = lessonsGroups {
                                        for groupName in data {
                                            let groupString = groupName.stringValue
                                            groups?.append(groupString)
                                        }
                                    }
                                    // Create new lesson and append it to
                                    let lesson = OneLesson(lessonNumber: lessonNumber, hashID: hashID, lessonType: lessonType, room: room, lessonStart: lessonStart, lessonEnd: lessonEnd, discipline: discipline, building: building, lector: lector, house: house, groups: groups)
                                    
                                    oneDay.lessons?.append(lesson)
                                }
                            }
                        }
                        oneWeek.days?.append(oneDay)
                        oneDay.clearAll()
                    }
                    oneSemDic[semestr.1["weekNum"].int!] = oneWeek
                    oneWeek.clearAll()
                }
                totalSchedule.append(oneSemDic)
            }
            print("Total schedule - \(totalSchedule)") // ВОТ ТУТ НОРМ ВЫВОДИТ!!!!!
            }, failure: {error in print(error)})
    }
}

