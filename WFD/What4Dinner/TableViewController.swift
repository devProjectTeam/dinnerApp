//
//  ViewController.swift
//  What4Dinner
//
//  Created by Thomas Miles on 10/6/19.
//  Copyright © 2019 Thomas Miles. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var foodChoices = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodChoices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodChoiceItemCell", for: indexPath)
        cell.textLabel?.text = foodChoices[indexPath.row]
        return cell

    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        
        let refreshAlert = UIAlertController(title: "Refresh", message: "Do you want to delete this post?", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            //perform your action
            
            self.foodChoices.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
            
    
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Item", message:"", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            self.foodChoices.append(textField.text!)
            self.tableView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter Location"
            textField = alertTextField
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    

}

