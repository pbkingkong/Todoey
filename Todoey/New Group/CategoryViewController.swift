//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Peter Buzek on 18.09.18.
//  Copyright © 2018 Peter Buzek. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    
    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
    loadCategories()
    }

    // MARK: - TableView DataSource Methods
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
        let category = categoryArray[indexPath.row]
        
 
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var  textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            // what will happen once the user klicks the bar button item
            
            
            let newCategory = Category(context: self.context)
            
            newCategory.name = textField.text!
        
            self.categoryArray.append(newCategory)
            
            self.saveCategory()
            
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
        
    }
    
    func saveCategory() {
        
        do {
            
            try context.save()
            
        } catch {
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    func loadCategories(with request:NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            categoryArray = try context.fetch(request)
        }
        catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
    
}
