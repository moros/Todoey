//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Doug Mason on 4/14/18.
//  Copyright © 2018 Doug Mason. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController
{
    let realm = try! Realm()
    var categoryResults: Results<Category>?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = self.categoryResults?[indexPath.row].name ?? "No categories added yet"
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete, let item = self.categoryResults?[indexPath.row] {
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
}
