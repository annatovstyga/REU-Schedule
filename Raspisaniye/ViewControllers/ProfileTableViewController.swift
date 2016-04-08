//
//  ProfileTableViewController.swift
//  Raspisaniye
//
//  Created by Ilya Mudriy on 14.02.16.
//  Copyright © 2016 rGradeStd. All rights reserved.
//

class ProfileTableViewController: UITableViewController {
    var plusH : CGFloat = 0
    override func viewDidLoad() {
        self.tableView.estimatedRowHeight = 120
        self.tableView.rowHeight = (self.view.frame.size.height / 4) + plusH
        super.viewDidLoad()
    }
    @IBOutlet weak var labelUpdate: UILabel!
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        isGCMReceived = defaults.objectForKey("isGCM") as? Bool ?? Bool()
         print(isGCMReceived)
        if((isGCMReceived) != false){
            let cell = tableView.dequeueReusableCellWithIdentifier("noChanges", forIndexPath: indexPath) as!CustomUpdateCell
       
        cell.updateLable.text = "Есть обновление рассписания\nНажмите для обновления"
        plusH = cell.frame.height
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier("noChanges", forIndexPath: indexPath) as!CustomUpdateCell
            
            return cell
        }
        
    }
    
}
