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
    var monthNumber = -1
    var dayNumber = -1
    
    override func viewDidLoad() {
        print("Month: \(monthNumber)")
        print("Day: \(dayNumber)")
    }
    
    @IBAction func addButtonPressed(sender : UIBarButtonItem){
        
        //Hard code a test event
        let newEvent = "Test Event: \(eventsArray.count + 1)"
        
        //Add new event to the Events Array
        eventsArray.append(newEvent)
        
        //Reload the data so it actually refreshes right away
        tableView.reloadData()
    }
    
    //Swipe Delete - Built in
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    //Actual Delete Process Code
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        //Make sure something is actually being deleted
        if (editingStyle == UITableViewCellEditingStyle.Delete){
            //Actually delete specific Event from the Events Array
            eventsArray.removeAtIndex(indexPath.row)
            
            //Utilize Built in iPhone animations for delete animation
            let sections = NSIndexSet(index: 0)
            tableView.reloadSections(sections, withRowAnimation: .Fade)
        }
    }
    
    //Setting number of sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //Setting number of rows
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Basic")!
        
        cell.textLabel?.text = eventsArray[indexPath.row]
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "SingleDaySegue"){
            let selectedRow = tableView.indexPathForSelectedRow?.row
            if let dest = segue.destinationViewController as? SingleDayTableViewController {
                dest.title = eventsArray[selectedRow!]
                dest.monthNumber = monthNumber
                dest.dayNumber = selectedRow! + 1
            }
        }
    }

    
}