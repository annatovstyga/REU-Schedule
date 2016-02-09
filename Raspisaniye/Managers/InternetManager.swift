//
//  InternetManager.swift
//  Raspisaniye
//
//  Created by Ilya Mudriy on 09.02.16.
//  Copyright © 2016 rGradeStd. All rights reserved.
//

import Foundation
import Alamofire
import MBProgressHUD

class InternetManager {
    // GET methods
    private let serverURL = "http://appreu.styleru.net/api"
    
    private let getGroupList   = "/groups/"
    private let getLectorsList = "/lectors/"
    private let getLessonsList = "/lessons"

    static let sharedInstance = InternetManager()
    
    func getGroupList(success:NSData -> (), failure:NSError-> ()){
        let getRequest = serverURL + getGroupList
        Alamofire.request(.GET, getRequest).responseJSON(completionHandler: {
            response in
            if let json = response.result.value {
                success(json as! NSData)
            }
        })
    }
}