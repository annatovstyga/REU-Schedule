//
//  LoginViewTwoController.swift
//  
//
//  Created by rGradeStd on 1/24/16.
//
//

import UIKit

class LoginViewTwoController: UIViewController,UITextFieldDelegate{
    

    
    
    // MARK: - Properties

    @IBOutlet weak var REALogo: UIImageView!
    var tempID:Int? = 0
    
    @IBOutlet weak var placeholderView: UIView!
    var timestamp: Int = 0
    var currentWeek: Int = 0
    // MARK: - View methods
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    @IBAction func enterClick(sender: AnyObject) {
        if (amistudent) {
            let groupNameTemp = textField.suggestionNormal
            let indexTemp = groupNamesList[groupNameTemp]
        
            if(indexTemp != nil){
                subjectName = (indexTemp!, groupNameTemp)
                self.enter()
            }
            else{
                self.showWarning()
            }
        } else {
            
            let lectorNameTemp = textField.suggestionNormal
            
            let indexTempLector = lectorsNamesList[lectorNameTemp]
            if(indexTempLector != nil){
                subjectName = (indexTempLector!, lectorNameTemp)
                self.enter()
            }
            else{
                self.showWarning()
            }
        }
 
        
    }
    @IBOutlet weak var textField: AutocompleteField!
    override func viewDidLoad() {
        textField.autocompleteType = .Sentence
        textField.returnKeyType = .Go
        if(amistudent){
        textField.suggestions = groupsArray
        }
        else{
            textField.suggestions = lectorsArray
        }
        textField.autocorrectionType = .No
         self.textField.delegate = self;
            for (value, _) in lectorsNamesList {
                lectorsArray.append(value)
            }
            lectorsArray.sortInPlace(before)
            
            for (value, _) in groupNamesList {
                groupsArray.append(value)
            }
            groupsArray.sortInPlace(before)
            //        groupsArray.sortInPlace(before)

        

            NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
            NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
            
            
 
                super.viewDidLoad()
        
    
    }
    
    func showWarning() {
        let alertController = UIAlertController(title: "Некоректный ввод!", message:
            "Попробуйте ввести название группы правильно", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    
    func enter()
    {
        defaults.setBool(true, forKey: "isLogined")
        //      (subjectIDMemory, subjectNameMemory)  = subjectName
        defaults.setObject(subjectName.0, forKey: "subjectID")
        defaults.setObject(subjectName.1, forKey: "subjectName")
        dispatch_async(dispatch_get_main_queue(), {
            self.updateSchedule(itemID: subjectName.0, successBlock: {
                successBlock in
                defaults.setValue(jsonDataList?.rawString(), forKey: "jsonData")
                self.performSegueWithIdentifier("fromLogin", sender: self)
            })
        })
    }
    private let data: [String] = {
            var data:[String] = []
            if(amistudent){
                 data = groupsArray
                            }
            else{
                data = lectorsArray
            }
                return data
    }()
    
    // MARK: - IBActions
    
    
    func updateSchedule(itemID itemID: Int, successBlock: Void -> ()) {
        
        InternetManager.sharedInstance.getLessonsList(["who":slString!,"id":itemID,"timestamp":0], success: {
            
            success in
            jsonDataList = success
            successBlock()
            }, failure: {error in print(error)})
    }

    
    
    // MARK: - Text field delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.textField.text = self.textField.suggestion
        self.view.endEditing(true)
        return false
    }

    

    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150
      
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
}