//
//  ReminderTableViewCell.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 11/15/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
  
    @IBOutlet weak var noteType: UILabel!
    @IBOutlet weak var noteDate: UILabel!
 
    @IBOutlet weak var group: UILabel!
    
    
    
@IBOutlet weak var content: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
