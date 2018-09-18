//
//  ViewController.swift
//  Todoey
//
//  Created by Peter Buzek on 14.09.18.
//  Copyright © 2018 Peter Buzek. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    

    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        print (dataFilePath!)
        
//        let newItem = Item()
//        newItem.title = "Find Mike"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "Buy Eggos"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Destroy Demogorgon"
//        itemArray.append(newItem3)
        loadItems()
    }

    // MARK - Table View Datasource Methods
    
    // __________________________
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //___________________________
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
      
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        let item = itemArray[indexPath.row]
        
        // use of ternary operator
        cell.accessoryType = item.done ? .checkmark : .none
        
       
        
        return cell
    }
    
    //___________________________
    
    // MARK - Table View Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = itemArray[indexPath.row]
        
        item.done = !item.done
        saveItems()
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //___________________________
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var  textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user klicks the bar button item
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
       
            
            self.saveItems()
            
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
    alert.addAction(action)
        present(alert,animated: true,completion: nil)
}
    func saveItems() {
        let  encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: self.dataFilePath!)
        } catch {
            print ("Error encoding item array \(error)")
        }
    }
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try  decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array \(error)")
            }
            }
            
    }
}

