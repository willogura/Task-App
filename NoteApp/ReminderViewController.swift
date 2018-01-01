//
//  ViewController.swift
//  ToDoList
//
//  Created by William Ogura on 3/5/17.
//  Copyright © 2017 William Ogura. All rights reserved.
//

import UIKit
import os.log


class ReminderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var newReminder = false
    @IBOutlet weak var tableView: UITableView!
   
    
    // when todays reminders button is pressed, call getTodaysReminders from dataHandler, then toggle the switch to all reminders. If all reminders is pressed, reload data from dataHandler.loadReminders()
    
    @IBAction func todaysRemindersPressed(_ sender: UIBarButtonItem) {
        
        if(sender.title == "Today's Reminders") {
        
        reminders = dataHandler.getTodaysReminders()
        
        print("TODAYS reminders pressed")
        
        tableView.reloadData()
            
            sender.title = "All Reminders"
        } else {
     
            
            reminders = dataHandler.loadReminders()!
            
            sender.title = "Today's Reminders"
            
            tableView.reloadData()
            
        }
    }
    
    
    @IBOutlet weak var group: UIBarButtonItem!
    
    
    @IBAction func groupButtonPressed(_ sender: Any) {
        
        
        switch (group.title!) {
        case "Group":
            
            reminders = dataHandler.loadGroupReminders()!
            
            
            
            tableView.reloadData()
            
            group.title = "Individual"
            
        case "Individual":
            
            
        reminders = dataHandler.loadIndividualReminders()!
        
        group.title = "All"
        
        tableView.reloadData()
            
            case "All":
            
                reminders = dataHandler.loadReminders()!
                
                group.title = "Group"
                
                tableView.reloadData()
            
            
        default:
            
            
            reminders = dataHandler.loadIndividualReminders()!
            
            group.title = "All"
            
            tableView.reloadData()
            
            
            
        }

        
    }
  

    //MARK: Properties
    
    var reminders = [Reminder]()
    
     var dataHandler = DataBaseHandler()
    
    override func viewDidLoad() {
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        super.viewDidLoad()
        
       
        
        // Load any saved reminders, otherwise load sample data.
        var tempReminders = dataHandler.loadReminders()
        
        if(tempReminders == nil) {
            
            print("NO reminders returned from loadReminders")
            
            dataHandler.createTables()
            
            if let savedReminders = loadAllReminders() {
                reminders += savedReminders
            }
            else {
                // Load the sample data.
                // loadSampleReminders()
            }
            
            
            
        } else {
            
            print("load works")
            reminders = tempReminders!
            
            for reminder in reminders {
                
                
                print(reminder.reminderName)
            }
        }
    
        
       
        
       // dataHandler.runTests()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        if(newReminder == true) {
            
            notifyUser()
            
            newReminder = false
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
        return reminders.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ReminderTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ReminderTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ReminderTableViewCell.")
        }
        
        // Fetches the appropriate reminder for the data source layout.
        let reminder = reminders[indexPath.row]
        
        cell.nameLabel.text = reminder.reminderName
        cell.reminderType.text = reminder.reminderType
        
        
        
        var dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        
        var strDate = dateFormatter.string(from: reminder.reminderDate)
        
        cell.reminderDate.text = strDate
        
        if(reminder.reminderPublic == true) {
            
            
            cell.group.text = "Group"
        } else {
            
            
            
            
            cell.group.text = "Individual"
        }
        
        return cell
    }
    
    public func notifyUser() {
        let alertController = UIAlertController(title: "New Group Reminder",
                                                message: "A group reminder will be added to your reminder list",
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
            reminders.remove(at: indexPath.row)
            saveReminders()
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
            os_log("Adding a new reminder.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let reminderDetailViewController = segue.destination as? DetailReminderViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedReminderCell = sender as? ReminderTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedReminderCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedReminder = reminders[indexPath.row]
            reminderDetailViewController.reminder = selectedReminder
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    
    //MARK: Actions
    
    @IBAction func unwindToReminderList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? DetailReminderViewController, let reminder = sourceViewController.reminder {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing reminder.
                reminders[selectedIndexPath.row] = reminder
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                
                
             
                // Add a new reminder.
                let newIndexPath = IndexPath(row: reminders.count, section: 0)
                if(reminder.reminderPublic == true) {
                    
                   newReminder = true
                    
                    
                } else {
                    
                    
                    newReminder = false
                }
                reminders.append(reminder)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // Save the reminders.
            saveReminders()
        }
    }
    
    //MARK: Private Methods
    

    
    private func saveReminders() {
        
        dataHandler.saveReminders(reminders: reminders)
    
 

    }
    
    private func loadIndividualReminders() -> [Reminder]?  {
        
        var reminders = dataHandler.loadIndividualReminders()
        
        
           return reminders
    
    }
    
    private func loadAllReminders() -> [Reminder]?  {
        
        var reminders = dataHandler.loadReminders()
        
        
        return reminders
        
    }

    private func loadGroupReminders() -> [Reminder]?  {
        
        var reminders = dataHandler.loadGroupReminders()
        
        
        return reminders
        
    }

    

}

