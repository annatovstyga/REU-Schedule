//
//  OneDay.swift
//  Raspisaniye
//
//  Created by rGradeStd on 2/18/16.
//  Copyright © 2016 rGradeStd. All rights reserved.
//

import Foundation

class OneDay {
    
    var dayName:  String?
    var lessons: [OneLesson]?
    
    // MARK: - Initializators
    init() {}

    init(dayName: String?, lessons: [OneLesson]?) {
        self.dayName = dayName
        self.lessons = lessons
    }
    
    // MARK: - Clear method
    func clearAll() {
        self.dayName = nil
        self.lessons = nil
    }
    
    // MARK: - Print in log
    func description() {
        print("\nDay name - \(dayName)\nLessons - \(lessons)")
    }
}