//
//  ViewController.swift
//  Todoey
//
//  Created by Doug Mason on 4/7/18.
//  Copyright © 2018 Doug Mason. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController
{
    let realm = try! Realm()
    var itemResults: Results<Item>?
    
    var selectedCategory : Category? {
        didSet {
            self.loadItems()
        }
    }
    
    //MARK - table datasource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let todo = self.itemResults?[indexPath.row] {
            cell.textLabel?.text = todo.title
            cell.accessoryType = todo.done ? .checkmark : .none
        }
        else {
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let item = self.itemResults?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            }
            catch {
                print("Error saving done status: \(error)")
            }
        }
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete, let item = self.itemResults?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(item)
                }
            }
            catch {
                print("Error deleting item: \(error)")
            }
        }
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return itemResults?.count ?? 1
    }
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem)
    {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item",
                                      message: "",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let item = Item()
                        item.title = textField.text!
                        item.dateCreated = Date()
                        currentCategory.items.append(item)
                    }
                }
                catch {
                    print("Error writing item: \(error)")
                }
            }
            
            self.tableView.reloadData()
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
        self.itemResults = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        self.tableView.reloadData()
    }
}

//MARK - Search bar methods

extension TodoListViewController : UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        self.itemResults = self.itemResults?
            .filter("title CONTAINS[cd] %@", searchBar.text!)
            .sorted(byKeyPath: "dateCreated", ascending: true)
        self.tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
