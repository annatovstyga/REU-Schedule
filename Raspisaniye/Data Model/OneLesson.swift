//
//  OneLesson.swift
//  Raspisaniye
//
//  Created by Ilya Mudriy on 10.02.16.
//  Copyright © 2016 rGradeStd. All rights reserved.
//

import Foundation
import SwiftyJSON

class OneLesson {
    
    var lessonNumber: Int?
    var hashID:     String?
    var lessonType: String?
    var room:       String?
    var groupID:    Int?
    var discipline: String?
    var building:   String?
    var lector:     String?
    var house:      String?
    var groups:     [AnyObject]?
    
    func initWith(hashID hashIDValue:String?, lessonTypeValue:String?, roomValue:String?, groupIDValue:Int?, disciplineValue:String?, buildingValue:String?, lectorValue:String?, houseValue:String?, groupsValue:[JSON]?) -> OneLesson {
        if let hashV = hashIDValue {hashID = hashV} else {hashID = ""}
        if let lessonTypeV = lessonTypeValue {lessonType = lessonTypeV} else {hashID = ""}
        if let roomV = roomValue {room = roomV} else {hashID = ""}
        if let groupIDV = groupIDValue {groupID = groupIDV} else {hashID = ""}
        if let disciplineV = disciplineValue {discipline = disciplineV} else {hashID = ""}
        if let buildingV = buildingValue {building = buildingV} else {hashID = ""}
        if let lectorV = lectorValue {lector = lectorV} else {hashID = ""}
        if let houseV = houseValue {house = houseV} else {hashID = ""}
        for item in groupsValue! {
            let object: AnyObject = item as! AnyObject
            groups?.append(object)
        }
        
        return self
    }
}