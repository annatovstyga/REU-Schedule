//
//  OneDay.swift
//  Raspisaniye
//
//  Created by rGradeStd on 2/18/16.
//  Copyright © 2016 rGradeStd. All rights reserved.
//

import Foundation

class OneDay {
    
    var Number:Int?
    var Lessons: [OneLesson]
    
    init () {
        self.Number = nil
        self.Lessons = []
    }
    
    func initWith() -> OneDay {
        
        return self
    }
}