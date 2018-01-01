//
//  NoteViewController.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 10/17/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import os.log

class DetailNoteViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
   
    @IBOutlet weak var picker: UIPickerView!

    @IBOutlet weak var saveButton: UIBarButtonItem!
    
 
    
    
    
    @IBOutlet weak var content: UITextView!
    
    
    
 
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func indexChanged(_ sender: Any) {
        
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            notePublicValue = false
        case 1:
            notePublicValue = true
        default:
            break
        }
        
        
    }
    
    var notePublicValue = false
    /*
         This value is either passed by `NoteTableViewController` in `prepare(for:sender:)`
         or constructed as part of adding a new Note.
     */
    var note: Note?
    
    var datePickerResult: Date?
    
    var pickerResult = "Work"
    
    var pickerData: [String] = [String]()
    
    func getPickerRow(note: Note) -> Int {
        
        var count = 0
        
        for value in pickerData {
            
            if(note.noteType == value) {
                
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
        
        // Set up views if editing an existing Note.
        if let note = note {
            
            navigationItem.title = note.noteName
            
            nameTextField.text = note.noteName
            if(note.notePublic == true) {
            
            segmentedControl.selectedSegmentIndex = 1
                
            } else {
                
                
                segmentedControl.selectedSegmentIndex = 0
            }
            let row = getPickerRow(note: note)
            
             picker.selectRow(row, inComponent: 0, animated: true)
            
            
            content.text = note.noteContent
        
        }
        
        
        
        // Enable the Save button only if the text field has a valid Note name.
        
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
        
        print("cancel called")
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddNoteMode = presentingViewController is UINavigationController
        
        if isPresentingInAddNoteMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            
            dismiss(animated: true, completion: nil)
            owningNavigationController.popViewController(animated: true)
        }
        else {
            
            dismiss(animated: true, completion: nil)
            fatalError("The NoteViewController is not inside a navigation controller.")
        }
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
   
        
        let noteName = nameTextField.text ?? ""
      
            
        let noteType = pickerResult
        
        var noteDate = Date()
        

      var noteContent = content.text
        
        // Set the Note to be passed to NoteTableViewController after the unwind segue.
        note = Note(noteName: noteName, noteType: noteType, noteDate: noteDate, notePublic: notePublicValue, noteContent: noteContent!)
        
     
    
        
    }
    
    
  
    
    //MARK: Actions
  
    
    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        
        let text = nameTextField.text ?? ""
        
        saveButton.isEnabled = !text.isEmpty
    }
    
}



