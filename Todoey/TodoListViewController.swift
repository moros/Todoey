//
//  ViewController.swift
//  Todoey
//
//  Created by Doug Mason on 4/7/18.
//  Copyright © 2018 Doug Mason. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController
{
    var itemArray : [Todo] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.itemArray = [
            Todo(value: "Find Mike"),
            Todo(value: "Bug Eggos"),
            Todo(value: "Destory Demogorgon")
        ]
    }
    
    //MARK - table datasource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let todo = self.itemArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = todo.value
        
        if todo.selected {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let todo = self.itemArray[indexPath.row]
        todo.selected = !todo.selected
        
        print("Selected item: \(todo.value!)")
        
        if todo.selected {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return itemArray.count
    }
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem)
    {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item",
                                      message: "",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemArray.append(Todo(value: textField.text!))
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action);
        
        present(alert, animated: true, completion: nil)
    }
}
