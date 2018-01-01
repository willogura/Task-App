//
//  Note.swift
//  ToDoList
//
//  Created by William Ogura on 3/23/17.
//  Copyright © 2017 William Ogura. All rights reserved.
//

import Foundation



class Note {
    
    //MARK: Properties
    
    var noteName: String
    
    var noteType: String
    
    var noteDate: Date
    
    var notePublic: Bool
    
    var noteContent: String
    //MARK: Archiving Paths
    // static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    //   static let ArchiveURL = DocumentsDirectory.appendingPathComponent("reminders")
    
    //MARK: Types
    
    
    //MARK: Initialization
    
    init(noteName: String, noteType: String, noteDate: Date, notePublic: Bool, noteContent: String) {
        
        // The name must not be empty
        
        // The rating must be between 0 and 5 inclusively
        
        
        // Initialization should fail if there is no name or if the rating is negative.
        
        
        // Initialize stored properties.
        self.noteName = noteName
        
        self.noteType = noteType
        
        self.noteDate = noteDate
        
        self.notePublic = notePublic
        
        self.noteContent = noteContent
        
    }
    
    //MARK: NSCoding
    
    
    
}
