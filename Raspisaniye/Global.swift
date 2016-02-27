
import Foundation
import UIKit
import RealmSwift

let defaults = NSUserDefaults.standardUserDefaults()
let realm = try! Realm()

var selectedDay:Int = 1
var weekNumber:Int = 1
//var Data:Array<AnyObject> = []

var isLogined = defaults.objectForKey("isLogined") as? Bool ?? Bool()
var amistudent: Bool = defaults.objectForKey("amistudent") as? Bool ?? Bool()
var subjectNameMemory = defaults.objectForKey("subjectName") as? String ?? String()
var subjectIDMemory   = defaults.objectForKey("subjectID") as? Int ?? Int()
var timestampMemory   = defaults.objectForKey("timestamp") as? Int ?? Int()
var currentWeekMemory = defaults.objectForKey("currentWeek") as? Int ?? Int()

var dictOfItems: [String:AnyObject] = [:]
var groupNamesList: [String: Int] = [:]
var lectorsNamesList: [String: Int] = [:]
var rowH: CGFloat = 0

var subjectName: (Int, String) = (0,"")
var totalSchedule: [OneWeek] = []
func before(value1: String, value2: String) -> Bool {
    return value1 < value2;
}
func beforeLes(value1: OneLesson, value2: OneLesson) -> Bool {
    return value1.lessonNumber < value2.lessonNumber;
}
struct GlobalColors{
    
    static let lightBlueColor = UIColor(red: 0/255, green: 118/255, blue: 225/255, alpha: 1.0)
    static let BlueColor = UIColor(red: 0/255,green: 71/255,blue: 119/255,alpha: 1.0)
}
func parseLessonType(notParsedString:String) -> String
{
    switch(notParsedString)
    {
        case "Л":
            return "Лекция"
        case "C":
            return "Семинар"
        default:
            return "Занятие"
    }
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




