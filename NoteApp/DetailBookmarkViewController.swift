//
//  BookmarkViewController.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 10/17/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import os.log

class DetailBookmarkViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
   
    @IBOutlet weak var picker: UIPickerView!

    @IBOutlet weak var saveButton: UIBarButtonItem!
    
 
    
    
        @IBOutlet weak var content: UITextField!
   
    
    
 
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func indexChanged(_ sender: Any) {
        
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            bookmarkPublicValue = false
        case 1:
            bookmarkPublicValue = true
        default:
            break
        }
        
        
    }
    
    var bookmarkPublicValue = false
    /*
         This value is either passed by `BookmarkTableViewController` in `prepare(for:sender:)`
         or constructed as part of adding a new Bookmark.
     */
    var bookmark: Bookmark?
    
    var datePickerResult: Date?
    
    var pickerResult = "Work"
    
    var pickerData: [String] = [String]()
    
    func getPickerRow(bookmark: Bookmark) -> Int {
        
        var count = 0
        
        for value in pickerData {
            
            if(bookmark.bookmarkType == value) {
                
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
        
        // Set up views if editing an existing Bookmark.
        if let bookmark = bookmark {
            
            navigationItem.title = bookmark.bookmarkName
            
            nameTextField.text = bookmark.bookmarkName
            if(bookmark.bookmarkPublic == true) {
            
            segmentedControl.selectedSegmentIndex = 1
                
            } else {
                
                
                segmentedControl.selectedSegmentIndex = 0
            }
            let row = getPickerRow(bookmark: bookmark)
            
             picker.selectRow(row, inComponent: 0, animated: true)
            
            
            content.text = bookmark.bookmarkContent
        
        }
        
        
        
        // Enable the Save button only if the text field has a valid Bookmark name.
        
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
        let isPresentingInAddBookmarkMode = presentingViewController is UINavigationController
        
        if isPresentingInAddBookmarkMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            
            dismiss(animated: true, completion: nil)
            owningNavigationController.popViewController(animated: true)
        }
        else {
            
            dismiss(animated: true, completion: nil)
            fatalError("The BookmarkViewController is not inside a navigation controller.")
        }
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
   
        
        let bookmarkName = nameTextField.text ?? ""
      
            
        let bookmarkType = pickerResult
        
        var bookmarkDate = Date()
        

      var bookmarkContent = content.text
        
        // Set the Bookmark to be passed to BookmarkTableViewController after the unwind segue.
        bookmark = Bookmark(bookmarkName: bookmarkName, bookmarkType: bookmarkType, bookmarkDate: bookmarkDate, bookmarkPublic: bookmarkPublicValue, bookmarkContent: bookmarkContent!)
        
     
    
        
    }
    
    
  
    
    //MARK: Actions
  
    
    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        
        let text = nameTextField.text ?? ""
        
        saveButton.isEnabled = !text.isEmpty
    }
    
}


extension Date
{
    
    init(dateString:String) {
        
        let dateStringFormatter = DateFormatter()
        
        dateStringFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        
        let d = dateStringFormatter.date(from: dateString)!
        
        self.init(timeInterval:0, since:d)
        
    }
}

