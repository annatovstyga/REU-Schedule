import UIKit

class LoginViewOneController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        // Create a variable that you want to send
        var whoamiString : String = "Вашу фамилию"
        if(segue.identifier == "studLogin")
        {
           whoamiString = "номер группы"
        }
        // Create a new variable to store the instance of PlayerTableViewController
        let destinationVC = segue.destinationViewController as! LoginViewTwoController
        destinationVC.whoamiStringTwo = whoamiString
    }
}