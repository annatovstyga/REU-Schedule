import UIKit

class LoginViewOneController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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