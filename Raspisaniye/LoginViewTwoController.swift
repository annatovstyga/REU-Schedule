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
    var Data: [AnyObject] = []
    var lectorsArray: [String] = []
    var groupsArray: [String] = []
    
    // MARK: - View methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (_, value) in lectorsNamesList {
            lectorsArray.append(value)
        }
        lectorsArray.sortInPlace(before)
        
        for (_, value) in groupNamesList {
            groupsArray.append(value)
        }
        groupsArray.sortInPlace(before)
        
        myPicker.dataSource = self
        myPicker.delegate = self
    }
    
    func before(value1: String, value2: String) -> Bool {
        return value1 < value2;
    }
    
    // MARK: - IBActions
    @IBAction func enterClick(sender: AnyObject) {
        defaults.setBool(true, forKey: "isLogined")
//        print(getDataForGroup("150")) // УЖЕ ПУСТОЙ
//        Data = getDataForGroup("150")
//        print("START")
//        print(Data)
//        print("FINISH")
        performSegueWithIdentifier("fromLogin", sender: sender)
    }
    
    @IBOutlet weak var myPicker: UIPickerView!
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
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
            if let group = groupNamesList[row] {
                subjectName = (row, group)
            }
        } else {
            if let lector = lectorsNamesList[row] {
                subjectName = (row, lector)
            }
        }
        defaults.setObject(subjectName.0, forKey: "subjectID")
        defaults.setObject(subjectName.1, forKey: "subjectName")
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