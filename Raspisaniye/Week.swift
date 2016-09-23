//
//  Week.swift
//  Raspisaniye
//
//  Created by Анна Товстыга on 23.09.16.
//  Copyright © 2016 rGradeStd. All rights reserved.
//

import Foundation
import RealmSwift

class Week: Object {
    var number: Int?
    var days = List<Day>()
    
//    override static func primaryKey() -> String? {
//        return "number"
//    }
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
