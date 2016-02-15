//
//  ProfileTableViewController.swift
//  Raspisaniye
//
//  Created by Ilya Mudriy on 14.02.16.
//  Copyright © 2016 rGradeStd. All rights reserved.
//

class ProfileTableViewController: UITableViewController {

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("changesCell", forIndexPath: indexPath) as! ProfileScreenTableViewCell
        
        return cell
    }
    
}
