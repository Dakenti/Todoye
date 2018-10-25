//
//  CategoryTableViewController.swift
//  Todoye
//
//  Created by Dake Aga on 10/24/18.
//  Copyright © 2018 Dake Aga. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categoryArray = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    // MARK: - table view datasource methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
        return cell
    }

    // MARK: - add new categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            let category = Category(context: self.context)
            category.name = textField.text!
            self.categoryArray.append(category)
            self.saveData()
        }
        alert.addTextField { (addTextField) in
            addTextField.placeholder = "New Category"
            textField = addTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - data manipulation methods

extension CategoryTableViewController{
    func saveData(){
        do{
            try context.save()
        } catch {
            print("failed to save Category list \(error)")
        }
        tableView.reloadData()
    }
    
    func loadData(with request: NSFetchRequest<Category> = Category.fetchRequest()){
        do{
            categoryArray = try context.fetch(request)
        } catch {
            print("failed to load Category list \(error)")
        }
        tableView.reloadData()
    }
}

// MARK: - Table View Delegate Methods

extension CategoryTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToItems", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoTableViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
}







