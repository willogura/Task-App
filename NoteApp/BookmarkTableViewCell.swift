//
//  ReminderTableViewCell.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 11/15/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class BookmarkTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
  
    @IBOutlet weak var bookmarkType: UILabel!
    @IBOutlet weak var bookmarkDate: UILabel!
 
    @IBOutlet weak var group: UILabel!
    

    
    @IBOutlet weak var content: UIButton!
    


    @IBAction func urlPressed(_ sender: Any) {
        
        let url = URL(string: content.currentTitle!)!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            //If you want handle the completion block than
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                print("Open url : \(success)")
            })
        }
        
        
        
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  

}
