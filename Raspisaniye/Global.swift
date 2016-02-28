
import Foundation
import UIKit
import SwiftyJSON

let defaults = NSUserDefaults.standardUserDefaults()
var jsonDataList:JSON?
var selectedDay:Int = 1
var weekNumber:Int = 1

var changes:Bool = false //Temp var

var isLogined = defaults.objectForKey("isLogined") as? Bool ?? Bool()
var amistudent: Bool = defaults.objectForKey("amistudent") as? Bool ?? Bool()
var subjectNameMemory = defaults.objectForKey("subjectName") as? String ?? String()
var subjectIDMemory   = defaults.objectForKey("subjectID") as? Int ?? Int()
var timestampMemory   = defaults.objectForKey("timestamp") as? Int ?? Int()
var currentWeekMemory = defaults.objectForKey("currentWeek") as? Int ?? Int()

var groupNamesList: [String: Int] = [:]
var lectorsNamesList: [String: Int] = [:]
var rowH: CGFloat = 0
var slString:String?
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
        case "С":
            return "Семинар"
        case "П":
            return "Практ. занятие"
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
    var count:Int = 0
    for item in totalSchedule
    {
        if(item.number <= week)
        {
            count++;
        }
        else
        {
            break
        }
    }
    return count
}


func parse(jsontoparse:JSON,successBlock: [OneWeek] -> ())
{
    HelperManager.sharedInstance.showMBProgressHUD()
    var schedule: [OneWeek] = []
    for semestr in jsontoparse["success"]["data"] {
        
        let oneWeek: OneWeek = OneWeek()
        oneWeek.number = semestr.1["weekNum"].int
        oneWeek.days = []
        // weekData - is one week
        for weekData in semestr.1 {
            
            // dayData - is one day
            for dayData in weekData.1 {
                let oneDay: OneDay = OneDay()
                oneDay.dayName = dayData.0
                oneDay.lessons = []
                
                // lessonData - is one lesson
                for lessonData in dayData.1 {
                    if(lessonData.1 != nil) {
                        // Main properties
                        let lessonNumber        = Int(lessonData.0)
                        let hashID: String?     = lessonData.1["hash_id"].string
                        let lessonType: String? = lessonData.1["lesson_type"].string
                        let room: String?       = lessonData.1["room"].string
                        let lessonStart: String? = lessonData.1["lesson_start"].string
                        let lessonEnd: String?   = lessonData.1["lesson_end"].string
                        let discipline: String? = lessonData.1["discipline"].string
                        let building: String?   = lessonData.1["building"].string
                        let lector: String?     = lessonData.1["lector"].string
                        let house: Int?         = lessonData.1["housing"].int
                        
                        var groups: [String]?   = []
                        let lessonsGroups = lessonData.1["groups"].array
                        if let data = lessonsGroups {
                            for groupName in data {
                                let groupString = groupName.stringValue
                                groups?.append(groupString)
                            }
                        }

                        let lesson = OneLesson(lessonNumber: lessonNumber, hashID: hashID, lessonType: lessonType, room: room, lessonStart: lessonStart, lessonEnd: lessonEnd, discipline: discipline, building: building, lector: lector, house: house, groups: groups)
                        
                        oneDay.lessons?.append(lesson)

                        
                    }
                }

                oneWeek.days?.append(oneDay)
                oneWeek.number = semestr.1["weekNum"].int!
            }

        }
        schedule.append(oneWeek)
        
    }
    successBlock(schedule)
    HelperManager.sharedInstance.hideMBProgressHUD()
}





