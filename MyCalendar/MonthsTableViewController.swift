//
//  MonthsTableViewController.swift
//  MyCalendar
//
//  Created by jbergandino on 3/14/16.
//  Copyright © 2016 gotrackingtechnologies. All rights reserved.
//

import Foundation
import UIKit

class MonthsTableViewController : UITableViewController {
    
    let monthArray = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Basic")!
    
        cell.textLabel?.text = monthArray[indexPath.row]
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "MonthsSegue"){
            let selectedRow = tableView.indexPathForSelectedRow?.row
            if let dest = segue.destinationViewController as? DaysTableViewController {
                dest.title = monthArray[selectedRow!]
                dest.monthNumber = selectedRow! + 1
            }
        }
    }

}