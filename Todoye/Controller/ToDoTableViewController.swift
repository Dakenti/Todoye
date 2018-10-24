//
//  ToDoTableViewController.swift
//  Todoye
//
//  Created by Dake Aga on 10/21/18.
//  Copyright © 2018 Dake Aga. All rights reserved.
//

import UIKit
import CoreData

class ToDoTableViewController: UITableViewController {
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var itemArray = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadData()
    }
    
    // MARK: - Add NavBar Button Configuration

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New ToDoye Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let item = Item(context: self.context)
            item.title = textField.text!
            item.done = false
            self.itemArray.append(item)
            self.save()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        ---------deletion of an element---------
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        save()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

// MARK: - Persistant data save, retrieve

extension ToDoTableViewController{
    
    func save(){
        do{
            try context.save()
        } catch {
            print("Failed to save in SQLite")
        }
        tableView.reloadData()
    }
    
    func loadData(){
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do{
            itemArray = try context.fetch(request)
        } catch {
            print("failure in reading data \(error)")
        }
    }
    //    func loadData(){
    //        if let data = try? Data(contentsOf: dataFilePath!) {
    //            let decoder = PropertyListDecoder()
    //            do{
    //                itemArray = try decoder.decode([Item].self, from: data)
    //            } catch {
    //                print("failed to retrice")
    //            }
    //        }
    //    }
    //
    //    func save(){
    //        let encoder = PropertyListEncoder()
    //
    //        do{
    //            let data = try encoder.encode(itemArray)
    //            try data.write(to: dataFilePath!)
    //        } catch {
    //            print("failed to save")
    //        }
    //        tableView.reloadData()
    //    }
}









