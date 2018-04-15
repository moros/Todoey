//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Doug Mason on 4/14/18.
//  Copyright © 2018 Doug Mason. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController
{
    let realm = try! Realm()
    var categoryResults: Results<Category>?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = 80.0
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.load()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem)
    {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            let category = Category()
            category.name = textField.text!
            category.color = UIColor.randomFlat().toHexString
            
            self.save(category: category)
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.categoryResults?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let item = self.categoryResults?[indexPath.row] {
            cell.textLabel?.text = item.name
            cell.backgroundColor = UIColor(hex: item.color)
        }
        else {
            cell.textLabel?.text = "No categories added yet"
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let destination = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destination.selectedCategory = self.categoryResults?[indexPath.row]
        }
    }
    
    func save(category: Category)
    {
        do {
            try realm.write {
                realm.add(category)
            }
        }
        catch {
            print("Error saving category: \(error)")
        }
    }
    
    func load()
    {
        self.categoryResults = realm.objects(Category.self)
        self.tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath)
    {
        if let item = self.categoryResults?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(item)
                }
            }
            catch {
                print("Error deleting category: \(error)")
            }
        }
    }
}
