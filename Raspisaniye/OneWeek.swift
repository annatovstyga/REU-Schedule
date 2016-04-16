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
    
    init(number: Int?, days: [OneDay]) {
        self.number = number
        self.days   = days
    }
    
    // MARK: - Clear method
    func clearAll() {
        self.number = nil
        self.days   = nil
    }
    
    // MARK: - Print in log
    func description() {
        print("\nnumber - \(number)\ndays - \(days)")
    }
}