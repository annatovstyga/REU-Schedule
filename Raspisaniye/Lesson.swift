//
//  Lesson.swift
//  Raspisaniye
//
//  Created by Анна Товстыга on 23.09.16.
//  Copyright © 2016 rGradeStd. All rights reserved.
//

import Foundation
import RealmSwift

class Lesson: Object {
    var lessonNumber: String?
    var hashID:     String?
    var lessonType: String?
    var room:       String?
    var lessonStart: String?
    var lessonEnd: String?
    var discipline: String?
    var building:   String?
    var lector:     String?
    var house:      Int?
    var startWeek: Int?
    var endWeek: Int?
    
//    override static func primaryKey() -> String? {
//        return "hashID"
//    }
//    required init() {}
//    
//    init(lessonNumber: Int?, hashID: String?, lessonType: String?, room: String?, lessonStart: String?, lessonEnd: String?, discipline: String?, building: String?, lector: String?, house: Int?, groups: [String]?,startWeek:Int?,endWeek:Int?) {
//        
//        self.lessonNumber = lessonNumber
//        self.hashID     = hashID
//        self.lessonType = lessonType
//        self.room       = room
//        self.lessonStart = lessonStart
//        self.lessonEnd   = lessonEnd
//        self.discipline = discipline
//        self.building   = building
//        self.lector     = lector
//        self.house      = house
//        self.groups     = groups
//        self.startWeek = startWeek
//        self.endWeek = endWeek
//    }
    

// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}


