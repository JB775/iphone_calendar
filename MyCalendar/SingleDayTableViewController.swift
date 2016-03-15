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
    
    var eventsArray : [AnyObject] = Array()
    var monthNumber = -1
    var dayNumber = -1
    
    override func viewDidLoad() {
        print("Month: \(monthNumber)")
        print("Day: \(dayNumber)")
    }
    
    @IBAction func addButtonPressed(sender : UIBarButtonItem){
        
        //Hard coded test event for testing
        let newEvent = "Test Event: \(eventsArray.count + 1)"
        
        //Define a key name
        let defaultsKey = "\(monthNumber)-\(dayNumber)"
        //Define the new Calendar Object
        let ce = CalendarEvent(withTitle: newEvent, andDateString: defaultsKey)
        //Need to create an encoded version of the new Calendar Event so it can be stored in NSUser Defaults
        let encodedCE = NSKeyedArchiver.archivedDataWithRootObject(ce)
        //Add new encoded event to the Events Array
        eventsArray.append(encodedCE)
        //This actually pushes the entire events array into the NSUserDefaults memory and links it to the defaultsKey key
        NSUserDefaults.standardUserDefaults().setObject(eventsArray, forKey: defaultsKey)
        //Syncronize with NSUserDefaults right away to make sure this gets saved
        NSUserDefaults.standardUserDefaults().synchronize()
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
            
            //Actually delete specific Event from the Events Array (not yet stored in NSData memory)
            eventsArray.removeAtIndex(indexPath.row)
            
            //Define the same key we have been using so you reference the correct array stored in memory
            let defaultsKey = "\(monthNumber)-\(dayNumber)"
            //Overwrite the array that is currently in NSData memory
            NSUserDefaults.standardUserDefaults().setObject(eventsArray, forKey: defaultsKey)
            //Syncronize to make sure this is handled immediately
            NSUserDefaults.standardUserDefaults().synchronize()
            
            //Utilize Built in iPhone animations for delete animation
            let sections = NSIndexSet(index: 0)
            tableView.reloadSections(sections, withRowAnimation: .Fade)
        }
    }
    
    //Setting number of sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //Populating Events Array from NSObject memory and setting number of rows for listview
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Define your known key name
        let defaultsKey = "\(monthNumber)-\(dayNumber)"
        //Reach into NSUser memory to Define a temporary variable to store the Events Array
        let arrayOfEvents = NSUserDefaults.standardUserDefaults().arrayForKey(defaultsKey)
        //If there is actually something in that temp variable, copy it to the actual Events Array
        //Comparing the variable name to itself is a nice shortcut to be used for optional binding (only bind if valid)
        if let arrayOfEvents = arrayOfEvents {
            eventsArray = arrayOfEvents
        }
        
        //Set the total number of rows to the length of the events array
        return eventsArray.count
    }
    
    //Get correct item from events array
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //Define the cell and use the built in reusable cell method for iOS efficiency
        let cell = tableView.dequeueReusableCellWithIdentifier("Basic")!
        
        //If the array was updated from NSData this if statement will be able to tell
        //if it was updated recently from NSData, the data will be archived in NSData format and needs to be
        //unarchived.  Once it is unarchived we set it as a CalendarEvent object which we created ourselves
        if let eventObject = eventsArray[indexPath.row] as? NSData {
            let ce = NSKeyedUnarchiver.unarchiveObjectWithData(eventObject) as! CalendarEvent
            //Now that this is a CalendarEvent object, we can grab the title and set it as the cell's text
            cell.textLabel?.text = ce.title
        }
        
        //Original code for setting text label to each cell directly from array
        //cell.textLabel?.text = eventsArray[indexPath.row] as! String
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "SingleDaySegue"){
            let selectedRow = tableView.indexPathForSelectedRow?.row
            if let dest = segue.destinationViewController as? SingleDayTableViewController {
                dest.title = eventsArray[selectedRow!] as! String
                dest.monthNumber = monthNumber
                dest.dayNumber = selectedRow! + 1
            }
        }
    }

    
}