//
//  HelperManager.swift
//  Raspisaniye
//
//  Created by Ilya Mudriy on 09.02.16.
//  Copyright © 2016 rGradeStd. All rights reserved.
//

import Foundation
import MBProgressHUD

class HelperManager {
    
    // MARK: Singleton
    static let sharedInstance = HelperManager()
    
    func showSpinner()
    {
        
    }
    // MARK: MBProgressHUD - Show & Hide
    func showMBProgressHUD() -> MBProgressHUD {
        let window = UIApplication.sharedApplication().windows.last
        MBProgressHUD.hideHUDForView(window, animated: true)
        let hud = MBProgressHUD.showHUDAddedTo(window, animated: true)
        hud.labelText = "Загрузка..."
        return hud
    }
    
    func hideMBProgressHUD() {
        let window = UIApplication.sharedApplication().windows.last
        MBProgressHUD.hideHUDForView(window, animated: true)
    }
}