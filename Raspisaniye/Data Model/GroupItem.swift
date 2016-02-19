//
//  GroupItem.swift
//  Raspisaniye
//
//  Created by Ilya Mudriy on 09.02.16.
//  Copyright © 2016 rGradeStd. All rights reserved.
//

import Foundation

class GroupItem {
    
    var id:   Int?
    var name: String?
    
    // MARK: - Initializators
    init() {}
    
    init(id: Int?, name: String?) {
        self.id   = id
        self.name = name
    }
}