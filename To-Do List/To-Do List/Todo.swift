//
//  Todo.swift
//  To-Do List
//
//  Created by Simon Cao on 10/18/16.
//  Copyright © 2016 Miracle. All rights reserved.
//

import UIKit

class Todo {
    
    var name: String
    var done: Bool
    var dateChecked: NSDate
    
    init(name: String, done: Bool, dateChecked: NSDate) {
        self.name = name
        self.done = done
        self.dateChecked = dateChecked
    }
}
