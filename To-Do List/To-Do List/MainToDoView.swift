//
//  MainToDoView.swift
//  To-Do List
//
//  Created by Simon Cao on 10/18/16.
//  Copyright © 2016 Miracle. All rights reserved.
//

import UIKit
import M13Checkbox
import Foundation

class MainToDoView: UITableViewController {
    
    var todos = [Todo]()
    
    @IBAction func unwindToViewController(sender: UIStoryboardSegue) {
        let todoView = sender.source as? NewTodoViewController
        let todoText = todoView?.newTodo.text
        if (todoText != "") {
            let todo = Todo(name: todoText!, done: false, dateChecked: NSDate())
            todos += [todo]
        }
        print("in segue")
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        var helloWorldTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.updatedTaskList), userInfo: nil, repeats: true)
    }
    
    func updatedTaskList() {
        var newTodoList = [Todo]()
        for todo in todos {
            if (todo.done == false || todo.dateChecked.timeIntervalSinceNow * -1 < 86400) {
                newTodoList += [todo]
            }
        }
        todos = newTodoList
        self.tableView.reloadData()
    }
    
//    func loadSampleTodos() {
//        let todo1 = Todo(name: "finish 161 HW")
//        let todo2 = Todo(name: "finish Decal HW")
//        let todo3 = Todo(name: "finish 161 Project")
//        todos += [todo1, todo2, todo3]
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "TodoCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ToDoCell
        let todo = todos[indexPath.row]

        cell.name.text = todo.name
        if (todo.done) {
            cell.checkbox.checkState = M13CheckboxState.checked
        }
        else {
            cell.checkbox.checkState = M13CheckboxState.unchecked
        }
        cell.checkbox.tag = indexPath.row
        cell.checkbox.addTarget(self, action:#selector(onValueChanged), for: UIControlEvents.valueChanged)

        return cell
    }
    
    func onValueChanged(sender: M13Checkbox) {
        if (!todos[sender.tag].done) {
            todos[sender.tag].dateChecked = NSDate()
            todos[sender.tag].done = true
            print(todos[sender.tag].dateChecked)
        }
        else {
            todos[sender.tag].done = false
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            print(todos)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "DailyStats") {
            let dailyView =  segue.destination as! DailyStatsViewController
            var completed = 0
            for todo in todos {
                if (todo.done) {
                    completed += 1
                }
            }
            dailyView.completed = completed
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
