//
//  ReminderViewController.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 10/17/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import os.log

class DetailReminderViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
   
    @IBOutlet weak var picker: UIPickerView!

    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    @IBAction func datePickerAction(sender: AnyObject) {
        
        var dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        
        var strDate = dateFormatter.string(from: datePicker.date)
        
        datePickerResult = datePicker.date
        
        print(datePicker.date)
        
    }
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func indexChanged(_ sender: Any) {
        
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            reminderPublicValue = false
        case 1:
            reminderPublicValue = true
        default:
            break
        }
        
        
    }
    
    var reminderPublicValue = false
    /*
         This value is either passed by `ReminderTableViewController` in `prepare(for:sender:)`
         or constructed as part of adding a new reminder.
     */
    var reminder: Reminder?
    
    var datePickerResult: Date?
    
    var pickerResult = "Work"
    
    var pickerData: [String] = [String]()
    
    func getPickerRow(reminder: Reminder) -> Int {
        
        var count = 0
        
        for value in pickerData {
            
            if(reminder.reminderType == value) {
                
                return count
                
                
            } else {
            
            count = count + 1
            
            }
        }
        
        return 0
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.picker.delegate = self
        
        self.picker.dataSource = self
        
        pickerData = ["Work","School", "Home", "Family", "Fun"]
        
    
        
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        
        // Set up views if editing an existing Reminder.
        if let reminder = reminder {
            
            navigationItem.title = reminder.reminderName
            
            nameTextField.text = reminder.reminderName
            if(reminder.reminderPublic == true) {
            
            segmentedControl.selectedSegmentIndex = 1
                
            } else {
                
                
                segmentedControl.selectedSegmentIndex = 0
            }
            let row = getPickerRow(reminder: reminder)
            
             picker.selectRow(row, inComponent: 0, animated: true)
            
            
            datePicker.date = reminder.reminderDate
        
        }
        
        
        
        // Enable the Save button only if the text field has a valid Reminder name.
        
        updateSaveButtonState()
    }
    
    
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        pickerResult = pickerData[row]
        
        
        
        
    }
   
    
    
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        // Disable the Save button while editing.
        
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        
        navigationItem.title = textField.text
        
    }
    


    
    //MARK: Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddReminderMode = presentingViewController is UINavigationController
         dismiss(animated: true, completion: nil)
        if isPresentingInAddReminderMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The ReminderViewController is not inside a navigation controller.")
        }
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
   
        
        let reminderName = nameTextField.text ?? ""
      
            
        let reminderType = pickerResult
        
        var reminderDate = datePickerResult
        

        
        if(reminderDate == nil) {
            
            
            reminderDate = Date()
        }
        
        // Set the reminder to be passed to ReminderTableViewController after the unwind segue.
        reminder = Reminder(reminderName: reminderName, reminderType: reminderType, reminderDate: reminderDate!, reminderPublic: reminderPublicValue)
        
     
    
        
    }
    
    
  
    
    //MARK: Actions
  
    
    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        
        let text = nameTextField.text ?? ""
        
        saveButton.isEnabled = !text.isEmpty
    }
    
}




