//
//  Reminder.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 11/10/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import os.log


class Reminder {
    
    //MARK: Properties
    
    var reminderName: String
   
    var reminderType: String
    
    var reminderDate: Date
    
    var reminderPublic: Bool
    
    //MARK: Archiving Paths
   // static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
 //   static let ArchiveURL = DocumentsDirectory.appendingPathComponent("reminders")
    
    //MARK: Types

    
    //MARK: Initialization
    
    init(reminderName: String, reminderType: String, reminderDate: Date, reminderPublic: Bool) {
        
        // The name must not be empty
      
        // The rating must be between 0 and 5 inclusively
      
        
        // Initialization should fail if there is no name or if the rating is negative.
      
        
        // Initialize stored properties.
        self.reminderName = reminderName
        
        self.reminderType = reminderType
        
        self.reminderDate = reminderDate
        
        self.reminderPublic = reminderPublic
    
    }
    
    //MARK: NSCoding

    

}



