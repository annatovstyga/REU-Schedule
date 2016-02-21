//
//  OneLesson.swift
//  Raspisaniye
//
//  Created by Ilya Mudriy on 10.02.16.
//  Copyright © 2016 rGradeStd. All rights reserved.
//

import Foundation

//var OneSemDic : [Int:AnyObject] = [:] TEMP
//var OneWeekDic : [Int:AnyObject] = [:]
//let OneDayDic : [Int:OneLesson] = [:]

class OneLesson {
    
    var lessonNumber: Int?
    var hashID:     String?
    var lessonType: String?
    var room:       String?
    var lessonStart: String?
    var lessonEnd: String?
    var discipline: String?
    var building:   String?
    var lector:     String?
    var house:      Int?
    var groups:     [String]?
    
    // MARK: - Initializators
    init() {}
    
    init(lessonNumber: Int?, hashID: String?, lessonType: String?, room: String?, lessonStart: String?, lessonEnd: String?, discipline: String?, building: String?, lector: String?, house: Int?, groups: [String]?) {
        
        self.lessonNumber = lessonNumber
        self.hashID     = hashID
        self.lessonType = lessonType
        self.room       = room
        self.lessonStart = lessonStart
        self.lessonEnd   = lessonEnd
        self.discipline = discipline
        self.building   = building
        self.lector     = lector
        self.house      = house
        self.groups     = groups

    }
}