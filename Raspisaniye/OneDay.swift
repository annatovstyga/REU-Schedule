//
//  OneDay.swift
//  Raspisaniye
//
//  Created by rGradeStd on 2/18/16.
//  Copyright © 2016 rGradeStd. All rights reserved.
//

import Foundation

class OneDay {
    
    var number:  Int?
    var lessons: [OneLesson]?
    
    // MARK: - Initializators
    init() {}

    init(number: Int?, lessons: [OneLesson]?) {
        self.number  = number
        self.lessons = lessons
    }
    
}