//
//  OneLesson.swift
//  Raspisaniye
//
//  Created by Ilya Mudriy on 10.02.16.
//  Copyright © 2016 rGradeStd. All rights reserved.
//

import Foundation

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
    var startWeek: Int?
    var endWeek: Int?
    
    // MARK: - Initializators
    init() {}
    
    init(lessonNumber: Int?, hashID: String?, lessonType: String?, room: String?, lessonStart: String?, lessonEnd: String?, discipline: String?, building: String?, lector: String?, house: Int?, groups: [String]?,startWeek:Int?,endWeek:Int?) {
        
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
        self.startWeek = startWeek
        self.endWeek = endWeek
    }
    
    // MARK: - Clear method
    func clearAll() {
        self.lessonNumber = nil
        self.hashID     = nil
        self.lessonType = nil
        self.room       = nil
        self.lessonStart = nil
        self.lessonEnd   = nil
        self.discipline = nil
        self.building   = nil
        self.lector     = nil
        self.house      = nil
        self.groups     = nil
    }
    
    // MARK: - Print in log
    
    func description() {
        print("\nlessonNumber - \(lessonNumber)\nhashID - \(hashID)\nlessonType - \(lessonType)\nroom - \(room)\nlessonStart - \(lessonStart)\nlessonEnd - \(lessonEnd)\ndiscipline - \(discipline)\nbuilding - \(building)\nlector - \(lector)\nhouse - \(house)\ngroups - \(groups)")
    }
}