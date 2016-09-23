//
//  Schedule.swift
//  Raspisaniye
//
//  Created by Анна Товстыга on 23.09.16.
//  Copyright © 2016 rGradeStd. All rights reserved.
//

import Foundation
import RealmSwift

class Schedule: Object {
    var weeks = List<Week>()
    dynamic var year:String = ""
   
    override static func primaryKey() -> String? {
        return "year"
    }
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
