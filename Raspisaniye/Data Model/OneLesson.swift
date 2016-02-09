//
//  OneLesson.swift
//  Raspisaniye
//
//  Created by Ilya Mudriy on 10.02.16.
//  Copyright © 2016 rGradeStd. All rights reserved.
//

import Foundation

class OneLesson {
    
    var hashID:     String?
    var lessonType: String?
    var room:       String?
    var groupID:    Int?
    var discipline: String?
    var building:   String?
    var lector:     String?
    var house:      String?
    var groups:     Array<AnyObject>?
    
    func initWith(hashID hashIDValue:String, lessonTypeValue:String, roomValue:String, groupIDValue:Int, disciplineValue:String, buildingValue:String, lectorValue:String, houseValue:String, groupsValue:Array<AnyObject>) -> OneLesson {
        hashID     = hashIDValue
        lessonType = lessonTypeValue
        room       = roomValue
        groupID    = groupIDValue
        discipline = disciplineValue
        building   = buildingValue
        lector     = lectorValue
        house      = houseValue
        groups     = groupsValue
        
        return self
    }
}