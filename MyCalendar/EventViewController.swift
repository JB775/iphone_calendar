//
//  EventViewController.swift
//  MyCalendar
//
//  Created by jbergandino on 3/14/16.
//  Copyright © 2016 gotrackingtechnologies. All rights reserved.
//

import Foundation
import UIKit

class EventViewController : UIViewController {
    
    var calendarEvent : CalendarEvent?
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var dateLabel : UILabel!
    
    //This will load immediately so this is where we are setting some initial values
    override func viewDidLoad() {
        titleLabel.text = calendarEvent?.title
        dateLabel.text = calendarEvent?.dateString
    }
    
}