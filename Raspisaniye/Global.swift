
import Foundation
import UIKit

let defaults = NSUserDefaults.standardUserDefaults()

var selectedDay:Int64 = 1
var weekNumber:Int = 1
//var Data:Array<AnyObject> = []

var isLogined = defaults.objectForKey("isLogined") as? Bool ?? Bool()
var amistudent: Bool = defaults.objectForKey("amistudent") as? Bool ?? Bool()

var dictOfItems: [String:AnyObject] = [:]
var groupNamesList: [String] = []
var lectorsNamesList: [String] = []
var rowH:CGFloat = 0
var subjectName:String?

struct GlobalColors{
    
    static let lightBlueColor = UIColor(red: 0/255, green: 118/255, blue: 225/255, alpha: 1.0)
    static let BlueColor = UIColor(red: 0/255,green: 71/255,blue: 119/255,alpha: 1.0)
}

func getWeekNumber() -> Int
{
    let start = "2015-09-01"
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    let startDate:NSDate = dateFormatter.dateFromString(start)!
    let endDate:NSDate = NSDate()
    
    func daysBetweenDate(startDate: NSDate, endDate: NSDate) -> Int
    {
        let calendar = NSCalendar.currentCalendar()
        
        let components = calendar.components([.Day], fromDate: startDate, toDate: endDate, options: [])
        
        return components.day
    }
    let days = daysBetweenDate(startDate, endDate: endDate) + 1
    let week = days/7 + 1
    return week
}




