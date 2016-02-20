//
//  Parse.swift
//  Raspisaniye
//
//  Created by rGradeStd on 2/21/16.
//  Copyright © 2016 rGradeStd. All rights reserved.
//

import Foundation

func getDataForGroup() -> Array<AnyObject> {
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
    var TotalSchedule : Array<AnyObject> = []
    InternetManager.sharedInstance.getLessonsList(["who":"group","id":195,"timestamp":0], success: {
        success in
        // semestr - is JSON item of week
        for semestr in success["success"]["data"] {
            // weekData - is JSON data of item with Days
            for weekData in semestr.1 {
                var OneSemDic : [Int:AnyObject] = [:]
                var OneWeekDic : [Int:AnyObject] = [:]
                if (weekData.1 != nil) {
                    // dayData - is JSON data of one day
                    for dayData in weekData.1 {
                        var OneDayDic : [Int:OneLesson] = [:]
                        if(dayData.1 != nil) {
                            // lessonData - is data of one lesson
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
                                    let lesson = OneLesson.init(lessonNumber: lessonNumber, hashID: hashID, lessonType: lessonType, room: room, lessonStart: lessonStart, lessonEnd: lessonEnd, discipline: discipline, building: building, lector: lector, house: house, groups: groups)
                                    OneDayDic[lesson.lessonNumber!] = lesson
                                    //                                        print(OneDayDic)
                                    break
                                }
                            }
                            OneWeekDic[getDayNumber(dayData.0)] = OneDayDic
                            //                            print(OneWeekDic)
                        }
                    }
                    
                    
                    OneSemDic[Int(semestr.1["weekNum"].stringValue)!] = OneWeekDic
                    TotalSchedule.append(OneSemDic)
                    //                    print(OneSemDic)
                    
                    break
                }
            }
            
            //??
        }
                    print(TotalSchedule)
        }, failure: {error in print(error)})
    return TotalSchedule
}

