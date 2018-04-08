//
//  ViewController.swift
//  Todoey
//
//  Created by Doug Mason on 4/7/18.
//  Copyright © 2018 Doug Mason. All rights reserved.
//

import UIKit

class Item
{
    var value : String?
    var selected : Bool = false
    
    init (value : String)
    {
        self.value = value
    }
}

class TodoListViewController: UITableViewController
{
    var itemArray : [Item] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.itemArray = [Item(value: "Find Mike"), Item(value: "Bug Eggos"), Item(value: "Destory Demogorgon")]
    }
    
    //MARK - table datasource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let item = self.itemArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = item.value
        
        if item.selected {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let item = self.itemArray[indexPath.row]
        item.selected = !item.selected
        
        print("Selected item: \(item.value!)")
        
        if item.selected {
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
    
}
