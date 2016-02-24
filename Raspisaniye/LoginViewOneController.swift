import UIKit

class LoginViewOneController: UIViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        InternetManager.sharedInstance.getGroupList({
            success in
            print(success)
            let groups = success["success"]["data"]
            for item in groups {
                let idGroup   = item.1["ID"].int!
                let nameGroup = item.1["name"].string!
                groupNamesList[nameGroup] = idGroup
            }
            
            }, failure:{error in print(error)
                self.showWarning()
        })
        InternetManager.sharedInstance.getLectorsList({
            success in
            let groups = success["success"]["data"]

            for item in groups {
                let idLector   = item.1["ID"].int!
                let nameLector = item.1["name"].string!
                lectorsNamesList[nameLector] = idLector
                
            }
            }, failure:{error in print(error)
                self.showWarning()
        })
//        groupNamesList.sortInPlace()
//        for lector in lectorsNamesList {
//            print(lector)
//        }
    }

    func showWarning() {
        let alertController = UIAlertController(title: "Connection error!", message:
            "При получении данных произошла проблема", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if(segue.identifier == "studLogin")
        {
            amistudent = true;
            defaults.setBool(true, forKey: "amistudent")
        }
        else
        {
            amistudent = false;
            defaults.setBool(false, forKey: "amistudent")
        }

    }
}