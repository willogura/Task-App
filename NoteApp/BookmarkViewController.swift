//
//  ViewController.swift
//  ToDoList
//
//  Created by William Ogura on 3/5/17.
//  Copyright © 2017 William Ogura. All rights reserved.
//

import UIKit
import os.log


class BookmarkViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var newBookmark = false
    @IBOutlet weak var tableView: UITableView!
   
    
    // when todays bookmarks button is pressed, call getTodaysBookmarks from dataHandler, then toggle the switch to all bookmarks. If all bookmarks is pressed, reload data from dataHandler.loadBookmarks()
    
    @IBAction func todaysRemindersPressed(_ sender: UIBarButtonItem) {
        
        if(sender.title == "Today's Bookmarks") {
        
      //  bookmarks = dataHandler.getTodaysBookmarks()
        
        print("TODAYS bookmarks pressed")
        
        tableView.reloadData()
            
            sender.title = "All Bookmarks"
        } else {
     
            
            bookmarks = dataHandler.loadBookmarks()!
            
            sender.title = "Today's Bookmarks"
            
            tableView.reloadData()
            
        }
    }
    
    

    
    
    @IBOutlet weak var group: UIBarButtonItem!
    
    
    @IBAction func groupButtonPressed(_ sender: Any) {
        
        
        switch (group.title!) {
        case "Group":
            
            bookmarks = dataHandler.loadGroupBookmarks()!
            
            
            
            tableView.reloadData()
            
            group.title = "Individual"
            
        case "Individual":
            
            
        bookmarks = dataHandler.loadIndividualBookmarks()!
        
        group.title = "All"
        
        tableView.reloadData()
            
            case "All":
            
                bookmarks = dataHandler.loadBookmarks()!
                
                group.title = "Group"
                
                tableView.reloadData()
            
            
        default:
            
            
            bookmarks = dataHandler.loadIndividualBookmarks()!
            
            group.title = "All"
            
            tableView.reloadData()
            
            
            
        }

        
    }
  

    //MARK: Properties
    
    var bookmarks = [Bookmark]()
    
     var dataHandler = DataBaseHandler()
    
    override func viewDidLoad() {
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        super.viewDidLoad()
        
       
        
        // Load any saved bookmarks, otherwise load sample data.
        var tempBookmarks = dataHandler.loadBookmarks()
        
        if(tempBookmarks == nil) {
            
            print("NO bookmarks returned from loadBookmarks")
            
            dataHandler.createTables()
            
            if let savedBookmarks = loadAllBookmarks() {
                bookmarks += savedBookmarks
            }
            else {
                // Load the sample data.
                // loadSampleBookmarks()
            }
            
            
            
        } else {
            
            print("load works")
            bookmarks = tempBookmarks!
            
            for bookmark in bookmarks {
                
                
                print(bookmark.bookmarkName)
            }
        }
    
        
       
        
       // dataHandler.runTests()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if(newBookmark == true) {
            
            notifyUser()
            
            newBookmark = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "BookmarkTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BookmarkTableViewCell  else {
            fatalError("The dequeued cell is not an instance of BookmarkTableViewCell.")
        }
        
        // Fetches the appropriate bookmark for the data source layout.
        let bookmark = bookmarks[indexPath.row]
        
        cell.nameLabel.text = bookmark.bookmarkName
        cell.bookmarkType.text = bookmark.bookmarkType
        
        
        
        var dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        
        var strDate = dateFormatter.string(from: bookmark.bookmarkDate)
        
       
       cell.content.setTitle(bookmark.bookmarkContent,for: .normal)
        
     
        
        if(bookmark.bookmarkPublic == true) {
            
            
            cell.group.text = "Group"
        } else {
            
            
            
            
            cell.group.text = "Individual"
        }
        
        return cell
    }
    
    public func notifyUser() {
        let alertController = UIAlertController(title: "New Group Bookmark",
                                                message: "A group bookmark will be added to your bookmark list",
                                                preferredStyle: .actionSheet)
        
        // Clear Action
        let clearAction = UIAlertAction(title: "Okay",
                                        style: .destructive,
                                        handler: { (action:UIAlertAction!) in
                                            print ("clear")
        })
        alertController.addAction(clearAction)
        
        // Cancel
      
        
        // Present Alert
        self.present(alertController,
                     animated: true,
                     completion:nil)
        
        
    }
    
    
    
    // Override to support conditional editing of the table view.
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            bookmarks.remove(at: indexPath.row)
            saveBookmarks()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    //MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new bookmark.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            
            
            
           
            guard let bookmarkDetailViewController = segue.destination as? DetailBookmarkViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedBookmarkCell = sender as? BookmarkTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedBookmarkCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedBookmark = bookmarks[indexPath.row]
            
            
       
            
            bookmarkDetailViewController.bookmark = selectedBookmark
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    
    //MARK: Actions
    
    @IBAction func unwindToBookmarkList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? DetailBookmarkViewController, let bookmark = sourceViewController.bookmark {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing bookmark.
                bookmarks[selectedIndexPath.row] = bookmark
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                
                
             
                // Add a new bookmark.
                let newIndexPath = IndexPath(row: bookmarks.count, section: 0)
                if(bookmark.bookmarkPublic == true) {
                    
                   newBookmark = true
                    
                    
                } else {
                    
                    
                    newBookmark = false
                }
                bookmarks.append(bookmark)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // Save the bookmarks.
            saveBookmarks()
        }
    }
    
    //MARK: Private Methods
    

    
    private func saveBookmarks() {
        
        dataHandler.saveBookmarks(bookmarks: bookmarks)
    
 

    }
    
    private func loadIndividualBookmarks() -> [Bookmark]?  {
        
        var bookmarks = dataHandler.loadIndividualBookmarks()
        
        
           return bookmarks
    
    }
    
    private func loadAllBookmarks() -> [Bookmark]?  {
        
        var bookmarks = dataHandler.loadBookmarks()
        
        
        return bookmarks
        
    }

    private func loadGroupBookmarks() -> [Bookmark]?  {
        
        var bookmarks = dataHandler.loadGroupBookmarks()
        
        
        return bookmarks
        
    }

    

}

