//
//  DataBaseHandler.swift
//  mod2
//
//  Created by William Ogura on 3/12/17.
//  Copyright © 2017 William Ogura. All rights reserved.
//

import Foundation

//import SQLite

import SQLite



//This class handles the database with Sqlite.Swift as a wrapper

class DataBaseHandler {
    
    
    var db: Connection?
    
    //askName: "Schedule Doctor", reminderType: "Family", reminderDate: reminderDate as Date    let individualReminders = Table("individualReminders")
    
    let individualReminders = Table("individualReminders")
    
    let groupReminders = Table("groupReminders")
    
    let reminderID = Expression<Int64>("reminderID")
    
    let reminderName = Expression<String?>("reminderName")
    
    let reminderType = Expression<String?>("reminderType")
    
    let reminderDate = Expression<Date>("reminderDate")
    
    
    
    
  let individualNotes = Table("individualNotes")
    
   let groupNotes = Table("groupNotes")
    
    let noteID = Expression<Int64>("noteID")
    
    let noteName = Expression<String?>("noteName")
    
    let noteType = Expression<String?>("noteType")
    
    let noteDate = Expression<Date>("noteDate")
    
    let noteContent = Expression<String?>("noteContent")
    
    
    
    
    let individualBookmarks = Table("individualBookmarks")
    
    let groupBookmarks = Table("groupBookmarks")
    
    let bookmarkID = Expression<Int64>("bookmarkID")
    
    let bookmarkName = Expression<String?>("bookmarkName")
    
    let bookmarkType = Expression<String?>("bookmarkType")
    
    let bookmarkDate = Expression<Date>("bookmarkDate")
    
    let bookmarkContent = Expression<String?>("bookmarkContent")
    
    
    
    
    
    
    
    
    
    
    //locate the ReminderList db file, then create connection
    init() {
        
        
     //   let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
           // .appendingPathComponent("ReminderList.sqlite")
        
        
        do {
            
            let databasePath = Bundle.main.path(forResource: "TaskList", ofType: "sqlite")!
            
            db = try Connection(databasePath)
            
        } catch {
            
            print("conection not working")
            
        }
        
        
        
    }
    
  
    
    
    func createTables() {
        
        
        do {
            
            
            try db!.run(individualReminders.create { t in
                
                t.column(reminderID, primaryKey: true)
                
                t.column(reminderName)
                
                t.column(reminderType)
                
                t.column(reminderDate)
            })
            
        } catch {
            
            print("create individualReminders failed")
            
            
        }
        
        
        do {
            
            
            try db!.run(groupReminders.create { t in
                
                t.column(reminderID, primaryKey: true)
                
                t.column(reminderName)
                
                t.column(reminderType)
                
                t.column(reminderDate)
            })
            
        } catch {
            
            print("create groupReminders failed")
            
            
        }
        
        
        do {
            
            
            try db!.run(groupNotes.create { t in
                
                t.column(noteID, primaryKey: true)
                
                t.column(noteName)
                
                t.column(noteType)
                
                t.column(noteDate)
                
                t.column(noteContent)
                
                
            })
            
        } catch {
            
            print("create group Notes failed")
            
            
        }
        
        do {
            
            
            try db!.run(individualNotes.create { t in
                
                t.column(noteID, primaryKey: true)
                
                t.column(noteName)
                
                t.column(noteType)
                
                t.column(noteDate)
                
                t.column(noteContent)
                
                
            })
            
        } catch {
            
            print("create group Notes failed")
            
            
        }

        
        do {
            
            
            try db!.run(groupBookmarks.create { t in
                
                t.column(bookmarkID, primaryKey: true)
                
                t.column(bookmarkName)
                
                t.column(bookmarkType)
                
                t.column(bookmarkDate)
                
                t.column(bookmarkContent)
                
                
            })
            
        } catch {
            
            print("create group Bookmarks failed")
            
            
        }
        
        do {
            
            
            try db!.run(individualBookmarks.create { t in
                
                t.column(bookmarkID, primaryKey: true)
                
                t.column(bookmarkName)
                
                t.column(bookmarkType)
                
                t.column(bookmarkDate)
                
                t.column(bookmarkContent)
                
                
            })
            
        } catch {
            
            print("create group Bookmarks failed")
            
            
        }
        
        
        
    }
    
    func printAllRecords() {
        
        
        do {
            
            
            
            for record in try db!.prepare(individualReminders) {
                print("id: \(record[reminderID]), name: \(record[reminderName]), type: \(record[reminderType]), date: \(record[reminderDate])")
                // id: 1, name: Optional("Alice"), email: alice@mac.com
            }
        } catch {
            
            
            print("Cannot print all records")
        }
        
        
    }
    
    func printSingleRecord(individualReminders: Table) {
        
        
        do {
            
            
            
            for record in try db!.prepare(individualReminders) {
                print("single record id: \(record[reminderID]), name: \(record[reminderName]), type: \(record[reminderType]), date: \(record[reminderDate])")
                // id: 1, name: Optional("Alice"), email: alice@mac.com
            }
        } catch {
            
            
            print("Cannot print all records")
        }
        
        
    }
    
    
    
    
    func addReminder(name: String, type: String, reminderDate: Date, reminderPublic: Bool)-> Int{
        
        
        
        
        // CREATE
        
        do{
            
            if(reminderPublic == false) {
            print("reminders false")
            
            let insert = individualReminders.insert(self.reminderName <- name, self.reminderType <- type, self.reminderDate <- reminderDate)
            
            let rowID = try db?.run(insert)
            
            return Int(rowID!)
            
            } else {
                
                
                print("reminders true")
                
                
                let insert = groupReminders.insert(self.reminderName <- name, self.reminderType <- type, self.reminderDate <- reminderDate)
                
                let rowID = try db?.run(insert)
                
                return Int(rowID!)
                
                
                
                
            }
            
            
            
            
            
        } catch {
            
            
            print("cannot add second record")
            
            
            return 0
            
        }
        
        
        
    }
    
    
    
    func addNote(name: String, type: String, noteDate: Date, notePublic: Bool, noteContent: String)-> Int{
        
        
        
        
        // CREATE
        
        do{
            
            if(notePublic == false) {
                
                
                let insert = individualNotes.insert(self.noteName <- name, self.noteType <- type, self.noteDate <- noteDate, self.noteContent <- noteContent)
                
                let rowID = try db?.run(insert)
                
                return Int(rowID!)
                
            } else {
                
            
                
                
                let insert = groupNotes.insert(self.noteName <- name, self.noteType <- type, self.noteDate <- noteDate, self.noteContent <- noteContent)
                
                let rowID = try db?.run(insert)
                
                return Int(rowID!)
                
                
                
                
            }
            
            
            
            
            
        } catch {
            
            
    
            
            return 0
            
        }
        
        
        
    }
    
    
    func addBookmark(name: String, type: String, bookmarkDate: Date, bookmarkPublic: Bool, bookmarkContent: String)-> Int{
        
        
        
        
        // CREATE
        
        do{
            
            if(bookmarkPublic == false) {
                
                
                let insert = individualBookmarks.insert(self.bookmarkName <- name, self.bookmarkType <- type, self.bookmarkDate <- bookmarkDate, self.bookmarkContent <- bookmarkContent)
                
                let rowID = try db?.run(insert)
                
                return Int(rowID!)
                
            } else {
                
                
                
                
                let insert = groupBookmarks.insert(self.bookmarkName <- name, self.bookmarkType <- type, self.bookmarkDate <- bookmarkDate, self.bookmarkContent <- bookmarkContent)
                
                let rowID = try db?.run(insert)
                
                return Int(rowID!)
                
                
                
                
            }
            
            
            
            
            
        } catch {
            
            
            
            
            return 0
            
        }
        
        
        
    }
    
    
    func getRecord(userID: Int64)-> Table? {
        
        do {
            
            let result = individualReminders.filter(reminderID == userID)
            
            
            return result
            
        } catch {
            
            
            return nil
        }
        
    }
    
    func replaceRecord(record: Table) {
        /*
         do {
         
         try db?.run(record.update(email <- reminderDate.replace("mac.com", with: "me.com")))
         
         // UPDATE "individualReminders" SET "email" = replace("email", 'mac.com', 'me.com')
         // WHERE ("id" = 1)
         
         } catch {
         
         print("replace does not work")
         
         }
         */
    }
    
    func deleteUser(record: Table) {
        
        do {
            
            
            
            
            try db?.run(record.delete())
            // DELETE FROM "individualReminders" WHERE ("id" = 1)
            
        } catch {
            
            
            print("cannot delete record")
            
        }
        
    }
    
    func getCount(record: Table) -> Int {
        
        do {
            
            
            let count = try db?.scalar(record.count) // 0
            
            // SELECT count(*) FROM "individualReminders"
            print("count : \(count)")
            
            return count!
        } catch {
            
            
            return 0
        }
    }
    
    
    func saveReminders(reminders: [Reminder]) {
        
        print("Save reminders called ")
        
        
    
        do {
            try db?.run(individualReminders.delete())
            
            
            try db?.run(groupReminders.delete())

        } catch {
            
            
            
        }
        
        for reminder in reminders {
            
           
                
            self.addReminder(name: reminder.reminderName, type: reminder.reminderType, reminderDate: reminder.reminderDate, reminderPublic: reminder.reminderPublic)
            
          
            
        }
        
        
    }
    
    
    func saveNotes(notes: [Note]) {
        
        print("Save  notes called ")
        
        
        
        do {
            try db?.run(individualNotes.delete())
            
            
            try db?.run(groupNotes.delete())
            
        } catch {
            
            
            
        }
        
        for note in notes {
            
            
            
            self.addNote(name: note.noteName, type: note.noteType, noteDate: note.noteDate, notePublic: note.notePublic, noteContent: note.noteContent)
            
            
            
        }
        
        
    }
    
    
    
    
    func saveBookmarks(bookmarks: [Bookmark]) {
        
        print("Save  bookmarks called ")
        
        
        
        do {
            try db?.run(individualBookmarks.delete())
            
            
            try db?.run(groupBookmarks.delete())
            
        } catch {
            
            
            
        }
        
        for bookmark in bookmarks {
            
            
            
            self.addBookmark(name: bookmark.bookmarkName, type: bookmark.bookmarkType, bookmarkDate: bookmark.bookmarkDate, bookmarkPublic: bookmark.bookmarkPublic, bookmarkContent: bookmark.bookmarkContent)
            
            
            
        }
        
        
    }
    
    
    //get todays date, then create start of date and end of date properties, then query database by filtering results with the two properties
    func getTodaysReminders() -> [Reminder] {
        
        var reminders = [Reminder]()
        
        var date = Date()
        
        var calendar = Calendar.current
        
        var startOfDay = calendar.startOfDay(for: date)
        
        
        
    
        var components = DateComponents()
        
        components.day = 1
        
        components.second = -1
        
        var endOfDay =  Calendar.current.date(byAdding: components, to: startOfDay)!
        
  //cannot query db with 'now' as the sqllite.swift wrapper does not support it, instead I filter the results by start and end date
        
        var filteredResults = individualReminders.filter(reminderDate >= calendar.startOfDay(for: date) && reminderDate <= endOfDay)
        
        var filteredgroupRemindersResults = groupReminders.filter(reminderDate >= calendar.startOfDay(for: date) && reminderDate <= endOfDay)

        do {
    
            for record in try db!.prepare(filteredResults) {
      
                print("id: \(record[reminderID]), name: \(record[reminderName]), date: \(record[reminderDate])")
                
                var reminder = Reminder(reminderName: record[reminderName]!, reminderType: record[reminderType]!, reminderDate: record[reminderDate], reminderPublic: false)
                
                reminders.append(reminder)
                
                
                // id: 1, name: Optional("Alice"), email: alice@mac.com
            }
            
            
            for record in try db!.prepare(filteredgroupRemindersResults) {
                
                print("id: \(record[reminderID]), name: \(record[reminderName]), date: \(record[reminderDate])")
                
                var reminder = Reminder(reminderName: record[reminderName]!, reminderType: record[reminderType]!, reminderDate: record[reminderDate], reminderPublic: true)
                
                reminders.append(reminder)
                
                
                // id: 1, name: Optional("Alice"), email: alice@mac.com
            }
            
     
            return reminders
            
            
        } catch {
            
            
            print("Cannot print all records")
        }
  
        return reminders
        
    }
    
    func loadReminders() -> [Reminder]? {
        
        
        
        var reminders = [Reminder]()
        
        var secondReminders = [Reminder]()
        print("loading all")
        
        do {
            
            
            
            for record in try db!.prepare(individualReminders) {
                
                
                print("gets here")
                
                print("id: \(record[reminderID]), name: \(record[reminderName]), date: \(record[reminderDate])")
                
                var reminder = Reminder(reminderName: record[reminderName]!, reminderType: record[reminderType]!, reminderDate: record[reminderDate], reminderPublic: false)
                
                reminders.append(reminder)
                
                
                // id: 1, name: Optional("Alice"), email: alice@mac.com
            }
            
            
            
            for record in try db!.prepare(groupReminders) {
                
                
                print("gets here")
                
                print("id: \(record[reminderID]), name: \(record[reminderName]), date: \(record[reminderDate])")
                
                var reminder = Reminder(reminderName: record[reminderName]!, reminderType: record[reminderType]!, reminderDate: record[reminderDate], reminderPublic: true)
                
                secondReminders.append(reminder)
                
                
                // id: 1, name: Optional("Alice"), email: alice@mac.com
            }
            
            
            for reminder in secondReminders {
                
                
                
                reminders.append(reminder)
                
                
            }
            
            
            
            return reminders
        } catch {
            
            
            print("Cannot print all records")
        }
        
        
        
        
        
        print("Load reminders called")
        
        return nil
    }
    
    
    
    func loadNotes() -> [Note]? {
        
        
        
        var notes = [Note]()
        
        var secondNotes = [Note]()
        print("loading all")
        
        do {
            
            
            
            for record in try db!.prepare(individualNotes) {
                
                
                print("gets here")
                
          
                
                var note = Note(noteName: record[noteName]!, noteType: record[noteType]!, noteDate: record[noteDate], notePublic: false, noteContent: record[noteContent]!)
                
                notes.append(note)
                
                
                // id: 1, name: Optional("Alice"), email: alice@mac.com
            }
            
            
            
            for record in try db!.prepare(groupNotes) {
                
         
                var note = Note(noteName: record[noteName]!, noteType: record[noteType]!, noteDate: record[noteDate], notePublic: true, noteContent: record[noteContent]!)
                
                secondNotes.append(note)
                
                
                // id: 1, name: Optional("Alice"), email: alice@mac.com
            }
            
            
            for note in secondNotes {
                
                
                
                notes.append(note)
                
                
            }
            
            
            
            return notes
        } catch {
            
            
            print("Cannot print all records")
        }
        
        
        
        
        
        print("Load notes called")
        
        return nil
    }
    
    
    
    
    func loadBookmarks() -> [Bookmark]? {
        
        
        
        var bookmarks = [Bookmark]()
        
        var secondBookmarks = [Bookmark]()
        print("loading all")
        
        do {
            
            
            
            for record in try db!.prepare(individualBookmarks) {
                
                
                print("gets here")
                
                
                
                var bookmark = Bookmark(bookmarkName: record[bookmarkName]!, bookmarkType: record[bookmarkType]!, bookmarkDate: record[bookmarkDate], bookmarkPublic: false, bookmarkContent: record[bookmarkContent]!)
                
                bookmarks.append(bookmark)
                
                
                // id: 1, name: Optional("Alice"), email: alice@mac.com
            }
            
            
            
            for record in try db!.prepare(groupBookmarks) {
                
                
                var bookmark = Bookmark(bookmarkName: record[bookmarkName]!, bookmarkType: record[bookmarkType]!, bookmarkDate: record[bookmarkDate], bookmarkPublic: true, bookmarkContent: record[bookmarkContent]!)
                
                secondBookmarks.append(bookmark)
                
                
                // id: 1, name: Optional("Alice"), email: alice@mac.com
            }
            
            
            for bookmark in secondBookmarks {
                
                
                
                bookmarks.append(bookmark)
                
                
            }
            
            
            
            return bookmarks
        } catch {
            
            
            print("Cannot print all records")
        }
        
        
        
        
        
        print("Load bookmarks called")
        
        return nil
    }

    
    func loadIndividualReminders() -> [Reminder]? {
        
        
        
        var reminders = [Reminder]()
        print("loading private")
        
        do {
            
            
            
            for record in try db!.prepare(individualReminders) {
                
                
                print("gets here")
                
                print("id: \(record[reminderID]), name: \(record[reminderName]), date: \(record[reminderDate])")
                
                var reminder = Reminder(reminderName: record[reminderName]!, reminderType: record[reminderType]!, reminderDate: record[reminderDate], reminderPublic: false)
                
                reminders.append(reminder)
                
                
                // id: 1, name: Optional("Alice"), email: alice@mac.com
            }
            
            
            
            return reminders
        } catch {
            
            
            print("Cannot print all records")
        }
        
        
        
        
        
        print("Load reminders called")
        
        return nil
    }

    
    func loadGroupReminders() -> [Reminder]? {
        
        
        
        var reminders = [Reminder]()
        print("loading public")
        
        do {
            
            
            
            for record in try db!.prepare(groupReminders) {
                
                
                
                print("GETS hered")
                print("id: \(record[reminderID]), name: \(record[reminderName]), date: \(record[reminderDate])")
                
                var reminder = Reminder(reminderName: record[reminderName]!, reminderType: record[reminderType]!, reminderDate: record[reminderDate], reminderPublic: true)
                
                reminders.append(reminder)
                
                
                // id: 1, name: Optional("Alice"), email: alice@mac.com
            }
            
            
            
            return reminders
        } catch {
            
            
            print("Cannot print all records")
        }
        
        
        
        
        
        print("Load reminders called")
        
        return nil
    }
    
    
    func loadIndividualNotes() -> [Note]? {
        
        
        
        var notes = [Note]()
        print("loading private")
        
        do {
            
            
            
            for record in try db!.prepare(individualNotes) {
                
                
           
                
                var note = Note(noteName: record[noteName]!, noteType: record[noteType]!, noteDate: record[noteDate], notePublic: false, noteContent: record[noteContent]!)
                
                notes.append(note)
                
                
                // id: 1, name: Optional("Alice"), email: alice@mac.com
            }
            
            
            
            return notes
        } catch {
            
            
            print("Cannot print all records")
        }
        
        
        
        
        
        print("Load notes called")
        
        return nil
    }
    
    
    
    
    func loadIndividualBookmarks() -> [Bookmark]? {
        
        
        
        var bookmarks = [Bookmark]()
        print("loading private")
        
        do {
            
            
            
            for record in try db!.prepare(individualBookmarks) {
                
                
                
                
                var bookmark = Bookmark(bookmarkName: record[bookmarkName]!, bookmarkType: record[bookmarkType]!, bookmarkDate: record[bookmarkDate], bookmarkPublic: false, bookmarkContent: record[bookmarkContent]!)
                
                bookmarks.append(bookmark)
                
                
                // id: 1, name: Optional("Alice"), email: alice@mac.com
            }
            
            
            
            return bookmarks
        } catch {
            
            
            print("Cannot print all records")
        }
        
        
        
        
        
        print("Load bookmarks called")
        
        return nil
    }
    
    

    
    
    
    func loadGroupNotes() -> [Note]? {
        
        
        
        var notes = [Note]()
        print("loading public")
        
        do {
            
            
            
            for record in try db!.prepare(groupNotes) {
                
                
                
            
                var note = Note(noteName: record[noteName]!, noteType: record[noteType]!, noteDate: record[noteDate], notePublic: true, noteContent: record[noteContent]!)
                
                notes.append(note)
                
                
                // id: 1, name: Optional("Alice"), email: alice@mac.com
            }
            
            
            
            return notes
        } catch {
            
            
            print("Cannot print all records")
        }
        
        
        
        
        
        print("Load notes called")
        
        return nil
    }


    
    
    
    func loadGroupBookmarks() -> [Bookmark]? {
        
        
        
        var bookmarks = [Bookmark]()
        print("loading public")
        
        do {
            
            
            
            for record in try db!.prepare(groupBookmarks) {
                
                
                
                
                var bookmark = Bookmark(bookmarkName: record[bookmarkName]!, bookmarkType: record[bookmarkType]!, bookmarkDate: record[bookmarkDate], bookmarkPublic: true, bookmarkContent: record[bookmarkContent]!)
                
                bookmarks.append(bookmark)
                
                
                // id: 1, name: Optional("Alice"), email: alice@mac.com
            }
            
            
            
            return bookmarks
        } catch {
            
            
            print("Cannot print all records")
        }
        
        
        
        
        
        print("Load bookmarks called")
        
        return nil
    }
    
    
    
    
}


