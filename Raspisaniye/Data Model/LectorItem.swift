//
//  LectorItem.swift
//  Raspisaniye
//
//  Created by Ilya Mudriy on 09.02.16.
//  Copyright © 2016 rGradeStd. All rights reserved.
//

import Foundation

class LectorItem {
    var id:   Int?
    var name: String?
    
    func initWith(itemID itemID: Int, itemName: String) -> LectorItem {
        id   = itemID
        name = itemName
        
        return self
    }

}