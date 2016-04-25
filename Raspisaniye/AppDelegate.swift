//Created by rGradeStd

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,GGLInstanceIDDelegate, GCMReceiverDelegate {
    
    var window: UIWindow?
    
    var connectedToGCM = false
    var subscribedToTopic = false
    var gcmSenderID: String?
    var registrationToken: String?
    var registrationOptions = [String: AnyObject]()
    
    let registrationKey = "onRegistrationCompleted"
    let messageKey = "onMessageReceived"
    let subscriptionTopic = "/topics/all"
    
    // [START register_for_remote_notifications]
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [NSObject: AnyObject]?) -> Bool {
//        SwiftSpinner.hide()
            // [START_EXCLUDE]
            // Configure the Google context: parses the GoogleService-Info.plist, and initializes
            // the services that have entries in the file
            var configureError:NSError?
            GGLContext.sharedInstance().configureWithError(&configureError)
            assert(configureError == nil, "Error configuring Google services: \(configureError)")
            gcmSenderID = GGLContext.sharedInstance().configuration.gcmSenderID
            // [END_EXCLUDE]
            // Register for remote notifications
                let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
                application.registerUserNotificationSettings(settings)
                application.registerForRemoteNotifications()
        
            
            // [END register_for_remote_notifications]
            // [START start_gcm_service]
            let gcmConfig = GCMConfig.defaultConfig()
            gcmConfig.receiverDelegate = self
            GCMService.sharedInstance().startWithConfig(gcmConfig)
            // [END start_gcm_service]
            GCMService.sharedInstance().connectWithHandler({(error:NSError?) -> Void in
            if let error = error {
                print("Could not connect to GCM: \(error.localizedDescription)")
            } else {
                self.connectedToGCM = true
                print("Connected to GCM")
                // [START_EXCLUDE]
                self.subscribeToTopic()
                // [END_EXCLUDE]

            }
        })
        
            return true
    }

    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        
        print(userInfo)
        //TEMPLATE FOR NOTIFICATIONS
//                let notification = UILocalNotification()
//                notification.alertAction = "Go back to App"
//                notification.alertBody = "This is a Notification!"
//                notification.userInfo = userInfo
//                UIApplication.sharedApplication().scheduleLocalNotification(notification)
        let warningString = userInfo["message"] as! String?
        //FOR STACKING ALERTS
//        let alertCtrl = UIAlertController(title: "Доступно обновление расписания", message: warningString! as String, preferredStyle: UIAlertControllerStyle.Alert)
//        alertCtrl.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//        // Find the presented VC...
//        var presentedVC = self.window?.rootViewController
//        while (presentedVC!.presentedViewController != nil)  {
//            presentedVC = presentedVC!.presentedViewController
//        }
//        presentedVC!.presentViewController(alertCtrl, animated: true, completion: nil)
        showWarning(warningString!,type: 1)
    }

    func subscribeToTopic() {
        // If the app has a registration token and is connected to GCM, proceed to subscribe to the
        // topic
        if(registrationToken != nil && connectedToGCM) {
            GCMPubSub.sharedInstance().subscribeWithToken(self.registrationToken, topic: subscriptionTopic,
                options: nil, handler: {(error:NSError?) -> Void in
                    if let error = error {
                        // Treat the "already subscribed" error more gently
                        if error.code == 3001 {
                            print("Already subscribed to \(self.subscriptionTopic)")
                        } else {
                            print("Subscription failed: \(error.localizedDescription)");
                        }
                    } else {
                        self.subscribedToTopic = true;
                        NSLog("Subscribed to \(self.subscriptionTopic)");
                    }
            })
        }
    }
    
    
    func applicationDidBecomeActive(application: UIApplication) {
        
        GCMService.sharedInstance().connectWithHandler({
            (error) -> Void in
            if error != nil {
                print("Could not connect to GCM: \(error.localizedDescription)")
            } else {
                self.connectedToGCM = true
                print("Connected to GCM")
            }
        })
        
    }

    // [START disconnect_gcm_service]
    func applicationDidEnterBackground(application: UIApplication) {
        GCMService.sharedInstance().disconnect()
        // [START_EXCLUDE]
        self.connectedToGCM = false
    }
    // [END disconnect_gcm_service]
    
    // [START receive_apns_token]
    func application( application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken
        deviceToken: NSData ) {
            // [END receive_apns_token]
            // [START get_gcm_reg_token]
            // Create a config and set a delegate that implements the GGLInstaceIDDelegate protocol.
            let instanceIDConfig = GGLInstanceIDConfig.defaultConfig()
            instanceIDConfig.delegate = self
            // Start the GGLInstanceID shared instance with that config and request a registration
            // token to enable reception of notifications
            GGLInstanceID.sharedInstance().startWithConfig(instanceIDConfig)
            registrationOptions = [kGGLInstanceIDRegisterAPNSOption:deviceToken,
                kGGLInstanceIDAPNSServerTypeSandboxOption:true]
            GGLInstanceID.sharedInstance().tokenWithAuthorizedEntity(gcmSenderID,
                scope: kGGLInstanceIDScopeGCM, options: registrationOptions, handler: registrationHandler)
            // [END get_gcm_reg_token]
    }
    
    // [START receive_apns_token_error]
    func application( application: UIApplication, didFailToRegisterForRemoteNotificationsWithError
        error: NSError ) {
            print("Registration for remote notification failed with error: \(error.localizedDescription)")
            // [END receive_apns_token_error]
            let userInfo = ["error": error.localizedDescription]
            NSNotificationCenter.defaultCenter().postNotificationName(
                registrationKey, object: nil, userInfo: userInfo)
    }
    

    

    func showWarning(withString:String,type:Int) {
        var messageString:String? = ""
        switch type {
        case 1:
            messageString = "Нажмите ОК для загрузки"
        default:
            messageString = ""
        }
        let alertController = UIAlertController(title: withString, message:
            messageString, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default,handler: {(alert: UIAlertAction!) in
            self.updateSch()
            }
            ))
        
        self.window?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func updateSch()
    {
        SwiftSpinner.show("")
        let id = defaults.objectForKey("subjectID") as! Int
        print("ID = \(id)")
        dispatch_async(dispatch_get_main_queue(), {
            self.updateSchedule(itemID: id, successBlock: {
                successBlock in
                dispatch_async(dispatch_get_main_queue(), {
                    parse(jsonDataList!,successBlock:
                        {
                            successBlock in
                            totalSchedule = successBlock
                            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let initialViewControlleripad : MMSwiftTabBarController = mainStoryboardIpad.instantiateViewControllerWithIdentifier("mainTabBar") as! MMSwiftTabBarController
                           let viewCR = self.getCurrentViewController() as! MMSwiftTabBarController
                        
//                            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
//                            self.window?.rootViewController = initialViewControlleripad
////                            self.window?.makeKeyAndVisible()
//                            self.window?.becomeKeyWindow()
//                            initialViewControlleripad.updateScheduleProperties(initialViewControlleripad.selectedDay)
//                            initialViewControlleripad.performSegueWithIdentifier("mainSegue", sender: initialViewControlleripad.tabBarButtons[initialViewControlleripad.selectedDay!])
                            viewCR.updateScheduleProperties(viewCR.selectedDay!)
                            viewCR.performSegueWithIdentifier("mainSegue", sender: viewCR.tabBarButtons[viewCR.selectedDay!])
                    })
                    
                })
            })
        })
    }
    
    func getNavigationController() -> UINavigationController? {
        
        if let navigationController = UIApplication.sharedApplication().keyWindow?.rootViewController  {
            
            return navigationController as? UINavigationController
        }
        return nil
    }
    
    // Returns the most recently presented UIViewController (visible)
    func getCurrentViewController() -> UIViewController? {
        
        // If the root view is a navigation controller, we can just return the visible ViewController
        if let navigationController = getNavigationController() {
            
            return navigationController.visibleViewController
        }
        
        // Otherwise, we must get the root UIViewController and iterate through presented views
        if let rootController = UIApplication.sharedApplication().keyWindow?.rootViewController {
            
            var currentController: UIViewController! = rootController
            
            // Each ViewController keeps track of the view it has presented, so we
            // can move from the head to the tail, which will always be the current view
            while( currentController.presentedViewController != nil ) {
                
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return UIViewController()
    }
    
        // Returns the navigation controller if it exists
     
    func updateSchedule(itemID itemID: Int, successBlock: Void -> ()) {
        var Who:String = "lector"
        if(amistudent)
        {
            Who = "group"
        }
        print(Who)
        InternetManager.sharedInstance.getLessonsList(["who":Who,"id":itemID,"timestamp":0], success: {
            success in
            jsonDataList = success
            successBlock()
            }, failure: {error in
                print(error)})
    }

    func registrationHandler(registrationToken: String!, error: NSError!) {
        if (registrationToken != nil) {
            self.registrationToken = registrationToken
            print("Registration Token: \(registrationToken)")
            self.subscribeToTopic()
            let userInfo = ["registrationToken": registrationToken]
            NSNotificationCenter.defaultCenter().postNotificationName(
                self.registrationKey, object: nil, userInfo: userInfo)
        } else {
            print("Registration to GCM failed with error: \(error.localizedDescription)")
            let userInfo = ["error": error.localizedDescription]
            NSNotificationCenter.defaultCenter().postNotificationName(
                self.registrationKey, object: nil, userInfo: userInfo)
        }
    }
    
    
    // [START on_token_refresh]
    func onTokenRefresh() {
        // A rotation of the registration tokens is happening, so the app needs to request a new token.
        print("The GCM registration token needs to be changed.")
        GGLInstanceID.sharedInstance().tokenWithAuthorizedEntity(gcmSenderID,
            scope: kGGLInstanceIDScopeGCM, options: registrationOptions, handler: registrationHandler)
    }
    // [END on_token_refresh]
    
    // [START upstream_callbacks]
    func willSendDataMessageWithID(messageID: String!, error: NSError!) {
        if (error != nil) {
            // Failed to send the message.
        } else {
            // Will send message, you can save the messageID to track the message
        }
    }
    
    func didSendDataMessageWithID(messageID: String!) {
        // Did successfully send message identified by messageID
    }
    // [END upstream_callbacks]
    
    func didDeleteMessagesOnServer() {
        // Some messages sent to this device were deleted on the GCM server before reception, likely
        // because the TTL expired. The client should notify the app server of this, so that the app
        // server can resend those messages.
    }
    
}