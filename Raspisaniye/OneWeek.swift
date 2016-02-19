//
//  OneWeek.swift
//  Raspisaniye
//
//  Created by rGradeStd on 2/18/16.
//  Copyright © 2016 rGradeStd. All rights reserved.
//

import Foundation

class OneWeek {
    
    var number: Int?
    var days:   [OneDay]?
    
    // MARK: - Initializators
    init() {}
    
    init(number: Int?, days: [OneDay]?) {
        self.number = number
        self.days   = days
    }
}