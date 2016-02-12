
import Foundation
import UIKit


let defaults = NSUserDefaults.standardUserDefaults()

var weekNumber:Int = 1
var isLogined = defaults.objectForKey("isLogined") as? Bool ?? Bool()
var amistudent : Bool = defaults.objectForKey("amistudent") as? Bool ?? Bool()

struct GlobalColors{
    
    static let lightBlueColor = UIColor(red: 0/255, green: 118/255, blue: 225/255, alpha: 1.0)
    static let BlueColor = UIColor(red: 0/255,green: 71/255,blue: 119/255,alpha: 1.0)
}