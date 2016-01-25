//
//  LoginViewTwoController.swift
//  
//
//  Created by rGradeStd on 1/24/16.
//
//

import UIKit

class LoginViewTwoController: UIViewController,UITextFieldDelegate{
    
    @IBAction func enterClick(sender: AnyObject) {
        defaults.setBool(true, forKey: "isLogined")
        performSegueWithIdentifier("fromLogin", sender: sender)
    }
    @IBOutlet weak var cstmTF: CustomTextFld!
    var whoamiStringTwo: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
         self.cstmTF.delegate = self;
        self.cstmTF.placegolderText += whoamiStringTwo
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y -= keyboardSize.height
        }
    }
    

    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y += keyboardSize.height
        }
    }
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: self.view.window)
    }
}
