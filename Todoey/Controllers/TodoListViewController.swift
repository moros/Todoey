//
//  ViewController.swift
//  Todoey
//
//  Created by Doug Mason on 4/7/18.
//  Copyright © 2018 Doug Mason. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController
{
    var itemArray = [Item]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.loadItems()
    }
    
    //MARK - table datasource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let todo = self.itemArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = todo.title
        cell.accessoryType = todo.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let todo = self.itemArray[indexPath.row]
        todo.done = !todo.done
        
        tableView.cellForRow(at: indexPath)?.accessoryType = todo.done ? .checkmark : .none
        tableView.deselectRow(at: indexPath, animated: true)
        
        AppDelegate.shared.saveContext()
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
            let context = AppDelegate.shared.persistentContainer.viewContext
            
            let item = Item(context: context)
            item.title = textField.text!
            item.done = false
            
            self.itemArray.append(item)
            self.tableView.reloadData()
            
            AppDelegate.shared.saveContext()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action);
        
        present(alert, animated: true, completion: nil)
    }
    
    func loadItems()
    {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            self.itemArray = try AppDelegate.shared.context.fetch(request)
        }
        catch {
            print("Error fetching data from context \(error)")
        }
    }
}
