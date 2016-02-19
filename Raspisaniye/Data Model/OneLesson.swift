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
    
    // MARK: - Initializators
    init() {}
    
    init(lessonNumber: Int?, hashID: String?, lessonType: String?, room: Int?, groupID: Int?, discipline: String?, building: String?, lector: String?, house: Int?) {
        
        self.lessonNumber = lessonNumber
        self.hashID     = hashID
        self.lessonType = lessonType
        self.room       = room
        self.groupID    = groupID
        self.discipline = discipline
        self.building   = building
        self.lector     = lector
        self.house      = house
        
        

//        for item in groupsValue {
//            let object: String = item.stringValue
//            groups?.append(object)
//        }
    }
    
}