//
//  CategoryTableViewController.swift
//  Todoye
//
//  Created by Dake Aga on 10/24/18.
//  Copyright © 2018 Dake Aga. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
        load()
    }
    
    // MARK: - table view datasource methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Yet"
        
        return cell
    }

    // MARK: - add new categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            let category = Category()
            category.name = textField.text!
            self.save(category: category)
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
    func save(category: Category){
        do{
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("failed to save Category list \(error)")
        }
        tableView.reloadData()
    }
    
    func load(){
        categories = realm.objects(Category.self)
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
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
}







