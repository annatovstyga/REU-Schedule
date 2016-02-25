//
//  LoginViewTwoController.swift
//  
//
//  Created by rGradeStd on 1/24/16.
//
//

import UIKit

class LoginViewTwoController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate{
    
    // MARK: - Properties
    var lectorsArray: [String] = []
    var groupsArray: [String] = []
    var tempID:Int? = 0

    var timestamp: Int = 0
    var currentWeek: Int = 0
    // MARK: - View methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (value, _) in lectorsNamesList {
            lectorsArray.append(value)
        }
        lectorsArray.sortInPlace(before)
        
        for (value, _) in groupNamesList {
            groupsArray.append(value)
        }
        groupsArray.sortInPlace(before)
//        groupsArray.sortInPlace(before)
        
        myPicker.dataSource = self
        myPicker.delegate = self
    }
    

    
    // MARK: - IBActions
    @IBAction func enterClick(sender: AnyObject) {
        defaults.setBool(true, forKey: "isLogined")
//        subjectName = (subjectIDMemory, subjectNameMemory)
        defaults.setObject(subjectName.0, forKey: "subjectID")
        defaults.setObject(subjectName.1, forKey: "subjectName")
        dispatch_async(dispatch_get_main_queue(), {
            self.updateSchedule(itemID: subjectName.0, successBlock: {
                successBlock in
                totalSchedule = successBlock
//                print(totalSchedule)
                self.performSegueWithIdentifier("fromLogin", sender: sender)
            })
        })
       
    }
    
    @IBOutlet weak var myPicker: UIPickerView!
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func updateSchedule(itemID itemID: Int, successBlock: [OneWeek] -> ()) {
        
        InternetManager.sharedInstance.getLessonsList(["who":"group","id":itemID,"timestamp":0], success: {
            success in
            var schedule: [OneWeek] = []
            
            self.timestamp   = success["success"]["timestamp"].intValue
            self.currentWeek = success["success"]["current_week"].intValue
            
            // semestr - is JSON item of week
            for semestr in success["success"]["data"] {
                var oneSemDic: [Int:OneWeek] = [:]
                
                
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
//                        if(dayData.1 != nil) {
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
//                                                                        print("One lesson - \(lesson.description())")
                                    oneDay.lessons?.append(lesson)
//                                    print(oneDay.dayName)
                                    
                                }
                            }
//                            oneWeek.days?.append(oneDay)
//                        }
//                                                print("One day - \(oneDay.description())")
                        oneWeek.days?.append(oneDay)
                        oneWeek.number = semestr.1["weekNum"].int!
//                        print(oneDay.dayName)
                        //                        oneDay.clearAll()
                    }
                    //                    print("One Week - \(oneWeek.description())")
//                    oneSemDic[semestr.1["weekNum"].int!] = oneWeek
                    //                    oneWeek.clearAll()
                }
                //                print("One SEM dic - \(oneSemDic.description)")
                schedule.append(oneWeek)
            }
            successBlock(schedule)
            }, failure: {error in print(error)})
    }
    
    // MARK: - Picker
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if (amistudent) {
            return (groupsArray.count)
        } else {
            return (lectorsArray.count)
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if(amistudent) {
            return "\(groupsArray[row])"
        } else {
            return "\(lectorsArray[row])"
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (amistudent) {
            let groupNameTemp = groupsArray[row]
            let indexTemp = groupNamesList[groupNameTemp]
            subjectName = (indexTemp!, groupNameTemp)
        } else {
            let lectorNameTemp = lectorsArray[row]
            let indexTempLector = lectorsNamesList[lectorNameTemp]
            subjectName = (indexTempLector!, lectorNameTemp)
    
        }

        print("Object that I checked - \(subjectName)")
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let titleDataTemp:String
        if (amistudent) {
            titleDataTemp = groupsArray[row]
        } else {
            titleDataTemp = lectorsArray[row]
        }
        let myTitle = NSAttributedString(string: titleDataTemp, attributes: [NSFontAttributeName:UIFont(name: "Helvetica", size: 14.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
        return myTitle
    }
    
    // MARK: - Text field delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

}