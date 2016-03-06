//
//  LoginViewTwoController.swift
//  
//
//  Created by rGradeStd on 1/24/16.
//
//

import UIKit
import RAMReel

class LoginViewTwoController: UIViewController,UICollectionViewDelegate{
    
    var dataSource: SimplePrefixQueryDataSource!

    var ramReel: RAMReel<RAMCell, RAMTextField, SimplePrefixQueryDataSource>!
    
    // MARK: - Properties

    var tempID:Int? = 0

    @IBOutlet weak var placeholderView: UIView!
    var timestamp: Int = 0
    var currentWeek: Int = 0
    // MARK: - View methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewDidLoad() {
        
        dispatch_async(dispatch_get_main_queue(), {
            for (value, _) in lectorsNamesList {
                lectorsArray.append(value)
            }
            lectorsArray.sortInPlace(before)
            
            for (value, _) in groupNamesList {
                groupsArray.append(value)
            }
            groupsArray.sortInPlace(before)
            //        groupsArray.sortInPlace(before)

        
        self.dataSource = SimplePrefixQueryDataSource(self.data)
        var  frameForReel = self.view.bounds
        frameForReel.origin.y = self.view.bounds.origin.y + 100
       
        self.ramReel = RAMReel(frame: frameForReel, dataSource: self.dataSource, placeholder: "Start by typing…") {
            print("Plain:", $0)
        }
        
        self.ramReel.hooks.append {
            let r = Array($0.characters.reverse())
            let j = String(r)
            print("Reversed:", j)
        
            if (amistudent) {
                let groupNameTemp = self.ramReel.selectedItem!
                let indexTemp = groupNamesList[groupNameTemp]
                if(indexTemp != nil){
                subjectName = (indexTemp!, groupNameTemp)
                self.enter()
                }
                else{
                    self.showWarning()
                }
            } else {
                
                let lectorNameTemp = self.ramReel.selectedItem!
                let indexTempLector = lectorsNamesList[lectorNameTemp]
                if(indexTempLector != nil){
                subjectName = (indexTempLector!, lectorNameTemp)
                self.enter()
                }
                else{
                    self.showWarning()
                }
            }
            
            print("ENTER")

            print("Object that I checked - \(self.ramReel.selectedItem)")
        }
            
        
        self.ramReel.resignFirstResponder()
        self.view.addSubview(self.ramReel.view)
        self.ramReel.view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.ramReel.prepareForViewing()
        })
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
        print("DADADA")
        self.view.endEditing(true)
        return false
    }

}