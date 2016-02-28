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


        self.tableView.estimatedRowHeight = 120
        self.tableView.rowHeight = self.view.frame.size.height / 5
        rowH = self.tableView.rowHeight

    }
    

    
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(day.lessons?.count != 0){
            return (day.lessons?.count)!
        }
        else{
            print("DADA")
            return 1
            
        }
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(day.lessons?.count != 0){
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! CustomTableViewCell
        
        cell.titleCell.text = day.lessons![indexPath.item].discipline
        
        cell.timeCell.text = "\(day.lessons![indexPath.item].lessonStart!) - \(day.lessons![indexPath.item].lessonEnd!)"
        
        cell.descriptionCell.text = "\(parseLessonType(day.lessons![indexPath.item].lessonType!)) | "
        if(day.lessons![indexPath.item].lector != nil){
            cell.descriptionCell.text?.appendContentsOf(day.lessons![indexPath.item].lector!)
        }
        cell.placeCell.text = "Ауд. \(day.lessons![indexPath.item].room!) (\(day.lessons![indexPath.item].building!) к. \(day.lessons![indexPath.item].house!))"
        return cell
        }
        else
        {
            print("noLessons")
        let cell = tableView.dequeueReusableCellWithIdentifier("noLessons", forIndexPath: indexPath)
            return cell
        }
    
    }
    
}
