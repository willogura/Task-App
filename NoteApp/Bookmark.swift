//
//  Bookmark.swift
//  ToDoList
//
//  Created by William Ogura on 3/23/17.
//  Copyright © 2017 William Ogura. All rights reserved.
//

import Foundation

import UIKit

class Bookmark {
    
    //MARK: Properties
    
    var bookmarkName: String
    
    var bookmarkType: String
    
    var bookmarkDate: Date
    
    var bookmarkPublic: Bool
    
    var bookmarkContent: String
    //MARK: Archiving Paths
    // static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    //   static let ArchiveURL = DocumentsDirectory.appendingPathComponent("reminders")
    
    //MARK: Types
    
    
    //MARK: Initialization
    
    init(bookmarkName: String, bookmarkType: String, bookmarkDate: Date, bookmarkPublic: Bool, bookmarkContent: String) {
        
        // The name must not be empty
        
        // The rating must be between 0 and 5 inclusively
        
        
        // Initialization should fail if there is no name or if the rating is negative.
        
        
        // Initialize stored properties.
        self.bookmarkName = bookmarkName
        
        self.bookmarkType = bookmarkType
        
        self.bookmarkDate = bookmarkDate
        
        self.bookmarkPublic = bookmarkPublic
        
        self.bookmarkContent = bookmarkContent
        
    }
    
    
    
    func clicked() {
        
        
        UIApplication.shared.openURL(URL(string: "http://www.stackoverflow.com")!)
    }
    
    //MARK: NSCoding
    
    
    
}
