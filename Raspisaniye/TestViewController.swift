//
//  TestViewController.swift
//  Raspisaniye
//
//  Created by Ilya Mudriy on 09.02.16.
//  Copyright © 2016 rGradeStd. All rights reserved.
//


class TestViewController: UIViewController {
    
    @IBAction func testButton(sender: UIButton) {
        InternetManager.sharedInstance.getGroupList({success in print(success)}, failure:{error in print(error)})
    }
}