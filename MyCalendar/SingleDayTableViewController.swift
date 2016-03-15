//
//  SingleDayTableViewController.swift
//  MyCalendar
//
//  Created by jbergandino on 3/14/16.
//  Copyright © 2016 gotrackingtechnologies. All rights reserved.
//

import Foundation
import UIKit

class SingleDayTableViewController : UITableViewController {
    
    var eventsArray : [String] = Array()
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Basic")!
        
        cell.textLabel?.text = eventsArray[indexPath.row]
        
        return cell
    }
    
}