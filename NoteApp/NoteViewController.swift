//
//  ViewController.swift
//  ToDoList
//
//  Created by William Ogura on 3/5/17.
//  Copyright © 2017 William Ogura. All rights reserved.
//

import UIKit
import os.log


class NoteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var newNote = false
    @IBOutlet weak var tableView: UITableView!
   
    
    // when todays notes button is pressed, call getTodaysNotes from dataHandler, then toggle the switch to all notes. If all notes is pressed, reload data from dataHandler.loadNotes()
    
    @IBAction func todaysRemindersPressed(_ sender: UIBarButtonItem) {
        
        if(sender.title == "Today's Notes") {
        
      //  notes = dataHandler.getTodaysNotes()
        
        print("TODAYS notes pressed")
        
        tableView.reloadData()
            
            sender.title = "All Notes"
        } else {
     
            
            notes = dataHandler.loadNotes()!
            
            sender.title = "Today's Notes"
            
            tableView.reloadData()
            
        }
    }
    
    
    @IBOutlet weak var group: UIBarButtonItem!
    
    
    @IBAction func groupButtonPressed(_ sender: Any) {
        
        
        switch (group.title!) {
        case "Group":
            
            notes = dataHandler.loadGroupNotes()!
            
            
            
            tableView.reloadData()
            
            group.title = "Individual"
            
        case "Individual":
            
            
        notes = dataHandler.loadIndividualNotes()!
        
        group.title = "All"
        
        tableView.reloadData()
            
            case "All":
            
                notes = dataHandler.loadNotes()!
                
                group.title = "Group"
                
                tableView.reloadData()
            
            
        default:
            
            
            notes = dataHandler.loadIndividualNotes()!
            
            group.title = "All"
            
            tableView.reloadData()
            
            
            
        }

        
    }
  

    //MARK: Properties
    
    var notes = [Note]()
    
     var dataHandler = DataBaseHandler()
    
    override func viewDidLoad() {
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        super.viewDidLoad()
        
       
        
        // Load any saved notes, otherwise load sample data.
        var tempNotes = dataHandler.loadNotes()
        
        if(tempNotes == nil) {
            
            print("NO notes returned from loadNotes")
            
            dataHandler.createTables()
            
            if let savedNotes = loadAllNotes() {
                notes += savedNotes
            }
            else {
                // Load the sample data.
                // loadSampleNotes()
            }
            
            
            
        } else {
            
            print("load works")
            notes = tempNotes!
            
            for note in notes {
                
                
                print(note.noteName)
            }
        }
    
        
       
        
       // dataHandler.runTests()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if(newNote == true) {
            
            notifyUser()
            
            newNote = false
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
        return notes.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "NoteTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NoteTableViewCell  else {
            fatalError("The dequeued cell is not an instance of NoteTableViewCell.")
        }
        
        // Fetches the appropriate note for the data source layout.
        let note = notes[indexPath.row]
        
        cell.nameLabel.text = note.noteName
        cell.noteType.text = note.noteType
        
        
        
        var dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        
        var strDate = dateFormatter.string(from: note.noteDate)
        
        cell.noteDate.text = strDate
        
        
        cell.content.text = note.noteContent
        
        if(note.notePublic == true) {
            
            
            cell.group.text = "Group"
        } else {
            
            
            
            
            cell.group.text = "Individual"
        }
        
        return cell
    }
    
    public func notifyUser() {
        let alertController = UIAlertController(title: "New Group Note",
                                                message: "A group note will be added to your note list",
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
            notes.remove(at: indexPath.row)
            saveNotes()
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
            os_log("Adding a new note.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let noteDetailViewController = segue.destination as? DetailNoteViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedNoteCell = sender as? NoteTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedNoteCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedNote = notes[indexPath.row]
            noteDetailViewController.note = selectedNote
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    
    //MARK: Actions
    
    @IBAction func unwindToNoteList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? DetailNoteViewController, let note = sourceViewController.note {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing note.
                notes[selectedIndexPath.row] = note
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                
                
             
                // Add a new note.
                let newIndexPath = IndexPath(row: notes.count, section: 0)
                if(note.notePublic == true) {
                    
                   newNote = true
                    
                    
                } else {
                    
                    
                    newNote = false
                }
                notes.append(note)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // Save the notes.
            saveNotes()
        }
    }
    
    //MARK: Private Methods
    

    
    private func saveNotes() {
        
        dataHandler.saveNotes(notes: notes)
    
 

    }
    
    private func loadIndividualNotes() -> [Note]?  {
        
        var notes = dataHandler.loadIndividualNotes()
        
        
           return notes
    
    }
    
    private func loadAllNotes() -> [Note]?  {
        
        var notes = dataHandler.loadNotes()
        
        
        return notes
        
    }

    private func loadGroupNotes() -> [Note]?  {
        
        var notes = dataHandler.loadGroupNotes()
        
        
        return notes
        
    }

    

}

