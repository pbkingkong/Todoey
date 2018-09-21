//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Peter Buzek on 18.09.18.
//  Copyright © 2018 Peter Buzek. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    loadCategories()
  
    }

    // MARK: - TableView DataSource Methods
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return categories?.count ?? 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added yet!"
        
        let category = categories![indexPath.row]
        
 
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var  textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            // what will happen once the user klicks the bar button item
            
            
            let newCategory = Category()
            
            newCategory.name = textField.text!
            
            self.saveCategory(category: newCategory)
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
        
    }
    
    func saveCategory(category: Category) {
        
        do {
            
            try realm.write {
                realm.add(category)
            }
            
        } catch {
            print("Error saving category \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
 
        tableView.reloadData()
    }
    
    
}
