//
//  MainTableViewController.swift
//  Raspisaniye
//
//  Created by rGradeStd on 2/9/16.
//  Copyright © 2016 rGradeStd. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var currentWeek: Int = 0
    
    var week: OneWeek = OneWeek()
    var day:  OneDay  = OneDay()
    var lesson: OneLesson = OneLesson()

    // MARK: - View methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)

        self.tableView.estimatedRowHeight = 120
        self.tableView.rowHeight = self.view.frame.size.height / 5
        rowH = self.tableView.rowHeight

    }
    

    
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(day.lessons?.count != nil){
            
            if(day.lessons?.count>4)
            {
                tableView.scrollEnabled = true
            }
            else
            {
                tableView.scrollEnabled = false
            }
            return (day.lessons?.count)!
        }
        else{
            return 1
            
        }
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(day.lessons?.count != nil){
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! CustomTableViewCell
        
        cell.titleCell.text = day.lessons![indexPath.item].discipline
        
        cell.timeCell.text = "\(day.lessons![indexPath.item].lessonStart!) - \(day.lessons![indexPath.item].lessonEnd!)"
        
        cell.descriptionCell.text = "\(parseLessonType(day.lessons![indexPath.item].lessonType!))  |  \(day.lessons![indexPath.item].startWeek!)-\(day.lessons![indexPath.item].endWeek!) неделя  |  "
        if((day.lessons![indexPath.item].lector != nil)&&(amistudent)){
            cell.descriptionCell.text?.appendContentsOf(day.lessons![indexPath.item].lector!)
        }
        else
        {
                for group in day.lessons![indexPath.item].groups!
                {
                cell.descriptionCell.text?.appendContentsOf("\(group) ")
                }
        }
        cell.placeCell.text = "Ауд. \(day.lessons![indexPath.item].room!) (\(day.lessons![indexPath.item].building!) к. \(day.lessons![indexPath.item].house!))"
    
        return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath)
            return cell
        }
    
    }
    
}
