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
        self.dayName  = dayName
        self.lessons = lessons
    }
    
}