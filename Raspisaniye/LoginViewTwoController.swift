//
//  LoginViewTwoController.swift
//  
//
//  Created by rGradeStd on 1/24/16.
//
//

import UIKit

class LoginViewTwoController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate{
    var Data:Array<AnyObject> = []
    func before(value1: String, value2: String) -> Bool {
        return value1 < value2;
    }
    
    @IBOutlet weak var myPicker: UIPickerView!
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if(amistudent){
            return (groupNamesList.count)
            
        }
        else{
            return (lectorsNamesList.count)
    }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if(amistudent){
        return "\(groupNamesList[row])"
    
        }
        else{
        return "\(lectorsNamesList[row])"
        }
    }
    
    @IBAction func enterClick(sender: AnyObject) {
        defaults.setBool(true, forKey: "isLogined")

        performSegueWithIdentifier("fromLogin", sender: sender)
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(amistudent){
            subjectName = groupNamesList[row]
        }
        else{
            subjectName = lectorsNamesList[row]
        }
        
    }
    override func viewDidLoad() {

        lectorsNamesList.sortInPlace(before)
        groupNamesList.sortInPlace(before)
        
        myPicker.dataSource = self
        myPicker.delegate = self


        super.viewDidLoad()
        

    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let titleDataTemp:String
        if(amistudent){
             titleDataTemp = groupNamesList[row]
            
        }
        else{
           titleDataTemp = lectorsNamesList[row]
        }
        let myTitle = NSAttributedString(string: titleDataTemp, attributes: [NSFontAttributeName:UIFont(name: "Helvetica", size: 14.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
        return myTitle
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

}