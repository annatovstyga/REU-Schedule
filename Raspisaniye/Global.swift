
import Foundation
import UIKit

let defaults = NSUserDefaults.standardUserDefaults()

var selectedDay:Int64 = 1
var weekNumber:Int = 1
var isLogined = defaults.objectForKey("isLogined") as? Bool ?? Bool()
var amistudent : Bool = defaults.objectForKey("amistudent") as? Bool ?? Bool()
var groupsList:     Array<AnyObject>?
var lectorsNamesList:   [String] = []
var groupNamesList:   [String] = []
var rowH:CGFloat = 0
var listOfLectors : Array<LectorItem> = []
struct GlobalColors{
    
    static let lightBlueColor = UIColor(red: 0/255, green: 118/255, blue: 225/255, alpha: 1.0)
    static let BlueColor = UIColor(red: 0/255,green: 71/255,blue: 119/255,alpha: 1.0)
}