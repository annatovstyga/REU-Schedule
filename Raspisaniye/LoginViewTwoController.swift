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
//      (subjectIDMemory, subjectNameMemory)  = subjectName
        defaults.setObject(subjectName.0, forKey: "subjectID")
        defaults.setObject(subjectName.1, forKey: "subjectName")
        dispatch_async(dispatch_get_main_queue(), {
            self.updateSchedule(itemID: subjectName.0, successBlock: {
                successBlock in
                defaults.setValue(jsonDataList?.rawString(), forKey: "jsonData")
                self.performSegueWithIdentifier("fromLogin", sender: sender)
            })
        })
       
    }
    
    @IBOutlet weak var myPicker: UIPickerView!
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func updateSchedule(itemID itemID: Int, successBlock: Void -> ()) {
        
        InternetManager.sharedInstance.getLessonsList(["who":slString!,"id":itemID,"timestamp":0], success: {
            
            success in
            jsonDataList = success
            successBlock()
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