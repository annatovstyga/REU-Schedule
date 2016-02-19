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
    var room:       Int?
    var groupID:    Int?
    var discipline: String?
    var building:   String?
    var lector:     String?
    var house:      Int?
//    var groups:     [String]?
    
    func initWith(hashID hashIDValue: String, lessonTypeValue: String, roomValue: Int, disciplineValue: String, buildingValue: String, lectorValue: String, houseValue: Int) -> OneLesson {
        
        hashID = hashIDValue
        lessonType = lessonTypeValue
        room = roomValue
        discipline = disciplineValue
        building = buildingValue
        lector = lectorValue
        house = houseValue

//        for item in groupsValue {
//            let object: String = item.stringValue
//            groups?.append(object)
//        }
        
        return self
    }
}