//
//  MainTableViewController.swift
//  Raspisaniye
//
//  Created by rGradeStd on 2/9/16.
//  Copyright © 2016 rGradeStd. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    // MARK: - Properties
    var totalSchedule: [[Int:OneWeek]] = []
    var timestamp: Int = 0
    var currentWeek: Int = 0
    
    var week: OneWeek = OneWeek()
    var day:  OneDay  = OneDay()
    var lesson: OneLesson = OneLesson()

    // MARK: - View methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to disp.lay an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        self.tableView.estimatedRowHeight = 120
        self.tableView.rowHeight = self.view.frame.size.height / 5
        rowH = self.tableView.rowHeight
        
        if(isLogined == true) {
            subjectName = (subjectIDMemory, subjectNameMemory)
            dispatch_async(dispatch_get_main_queue(), {
                self.updateSchedule(itemID: subjectName.0, successBlock: {
                    successBlock in
                    self.totalSchedule = successBlock
                    self.updateScheduleProperties()
                    self.tableView.reloadData()
                })
            })
        }
    }
    
    // MARK: - Update schedule
    func updateScheduleProperties() {
//        if (self.totalSchedule.count != 0) {
            for item in self.totalSchedule {
                if let week = item[self.currentWeek] {
                    print("week.days - \(week.description())")
                    if let days = week.days {
//                        self.day = days[selectedDay]
                    for day in days {
                        self.day = day
                        if let lessons = self.day.lessons {
                            for lesson in lessons {
                                self.lesson = lesson
                                print("lesson \(self.lesson.description())")
//                                break
                            }
                        }
                    }
                }
            }
        }
    }
    
    func updateSchedule(itemID itemID: Int, successBlock: [[Int:OneWeek]] -> ()) {
        
        InternetManager.sharedInstance.getLessonsList(["who":"group","id":itemID,"timestamp":0], success: {
            success in
            var schedule: [[Int:OneWeek]] = []
            
            self.timestamp   = success["success"]["timestamp"].intValue
            self.currentWeek = success["success"]["current_week"].intValue
            
            // semestr - is JSON item of week
            for semestr in success["success"]["data"] {
                var oneSemDic: [Int:OneWeek] = [:]
                let oneWeek: OneWeek = OneWeek()
                let oneDay: OneDay = OneDay()
                oneWeek.number = semestr.1["weekNum"].int
                oneWeek.days = []
                // weekData - is one week
                for weekData in semestr.1 {
                    // dayData - is one day
                    for dayData in weekData.1 {
                        oneDay.dayName = dayData.0
                        oneDay.lessons = []
                        if(dayData.1 != nil) {
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
                                    // Groups property
                                    var groups: [String]?   = []
                                    let lessonsGroups = lessonData.1["groups"].array
                                    if let data = lessonsGroups {
                                        for groupName in data {
                                            let groupString = groupName.stringValue
                                            groups?.append(groupString)
                                        }
                                    }
                                    // Create new lesson and append it to
                                    let lesson = OneLesson(lessonNumber: lessonNumber, hashID: hashID, lessonType: lessonType, room: room, lessonStart: lessonStart, lessonEnd: lessonEnd, discipline: discipline, building: building, lector: lector, house: house, groups: groups)
//                                    print("One lesson - \(lesson.description())")
                                    oneDay.lessons?.append(lesson)
                                }
                            }
                        }
//                        print("One day - \(oneDay.description())")
                        oneWeek.days?.append(oneDay)
//                        oneDay.clearAll()
                    }
//                    print("One Week - \(oneWeek.description())")
                    oneSemDic[semestr.1["weekNum"].int!] = oneWeek
//                    oneWeek.clearAll()
                }
//                print("One SEM dic - \(oneSemDic.description)")
                schedule.append(oneSemDic)
            }
            successBlock(schedule)
            }, failure: {error in print(error)})
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! CustomTableViewCell

        
        return cell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
