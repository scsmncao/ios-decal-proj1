//
//  ToDoCell.swift
//  To-Do List
//
//  Created by Simon Cao on 10/18/16.
//  Copyright © 2016 Miracle. All rights reserved.
//

import UIKit
import M13Checkbox

class ToDoCell: UITableViewCell {

    @IBOutlet var name: UILabel!
    @IBOutlet var checkbox: M13Checkbox!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
