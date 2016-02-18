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
    var groups:     [String]?
    
    func initWith(hashID hashIDValue: String, lessonTypeValue: String, roomValue: String, groupIDValue: Int, disciplineValue: String, buildingValue: String, lectorValue: String, houseValue: String, groupsValue:[JSON]) -> OneLesson {
        
        hashID = hashIDValue
        lessonType = lessonTypeValue
        room = roomValue
        groupID = groupIDValue
        discipline = disciplineValue
        building = buildingValue
        lector = lectorValue
        house = houseValue

        for item in groupsValue {
            let object: String = item.stringValue
            groups?.append(object)
        }
        
        return self
    }
}