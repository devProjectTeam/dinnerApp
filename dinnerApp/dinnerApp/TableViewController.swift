//
//  ViewController.swift
//  dinnerApp
//
//  Created by Shivashankar on 10/1/19.
//  Copyright © 2019 skyenov. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    //let dummyData:[[String]] = [["McDonalds","123 fake street"],["Dominoes", "1114 Somewhere Place"],["Pasta"]]
    //var numberOfPlaces:[Places] = [Places(placeName: "Mc D"),Places(placeName: "123 Fake Street")]
    
    var placesArray = [Placeslist]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        // we use self here to avoid changing the tab bar item title as well.
        //see:stackoverflow.com/questions/25167458/changing-navigation-title-programmatically
        //self.navigationItem.title = "Select 3 choices"
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            
            return placesArray.count
        } else
        {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create cell from dequeue pile and bind to "Cell" identifier from TableView
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let place = placesArray[indexPath.row]
        // add place title
        cell.textLabel?.text = place.placeName
        //cell.textLabel?.text = dummyData[indexPath.row][0]
        
        // if location exists also add to cell description
        //cell.detailTextLabel?.text = dummyData[indexPath.row].count > 1 ? dummyData[indexPath.row][1] : ""
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath:IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
    
    /* below code to implement later
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.numberOfPlaces[sourceIndexPath.row]
        numberOfPlaces.remove(at: sourceIndexPath.row)
        numberOfPlaces.insert(movedObject, at: destinationIndexPath.row)
        debugPrint("\(sourceIndexPath.row) => \(destinationIndexPath.row)")
        // To check for correctness enable: self.tableView.reloadData()
    }
    */
    
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    //This below method is for pushing to editPlacesTableViewController upon selecting cell from tableviewcontroller 
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            //Added alert when deleting from list to confirm
            let refreshAlert = UIAlertController(title: "Confirm Delete", message: "Do you want to delete this Item?", preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                //perform your action
                
                //self.numberOfPlaces.remove(at: indexPath.row)
                //tableView.deleteRows(at: [indexPath], with: .automatic)
                self.context.delete(self.placesArray[indexPath.row])
                self.placesArray.remove(at: indexPath.row)
                
                tableView.deleteRows(at: [indexPath], with: .automatic)
               // Places.saveToFile(selectedPlaces: self.numberOfPlaces)
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
            
            
            
            present(refreshAlert, animated: true, completion: nil)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let place = placesArray[indexPath.row]
        performSegue(withIdentifier: "editPlace", sender: place)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editPlace"
        {
            let indexPath = tableView.indexPathForSelectedRow!
            let places = placesArray[indexPath.row]
            let navController = segue.destination as! UINavigationController
            let editAddedPlacesTableViewController = navController.topViewController  as! editPlacesTableViewController
            editAddedPlacesTableViewController.selectedPlace  = places.placeName ?? ""
            let editAddedPlacesTableViewControllerIndexPath = navController.topViewController as! editPlacesTableViewController
            editAddedPlacesTableViewControllerIndexPath.selectedIndexpath = indexPath.row
            
            
        }
    }
    
    func loadItems() {
        let request : NSFetchRequest<Placeslist> = Placeslist.fetchRequest()
        do {
            placesArray = try context.fetch(request)
        } catch
        {
            print("Error fetching data from context \(error)")
        }
        
    }
    
    
    
    //To reload list of places tableview
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loadItems()
        tableView.reloadData()
    }
    @IBAction func editPressed(_ sender: UIBarButtonItem) {
        
        self.isEditing = !self.isEditing

    }
    
    @IBAction func unwindToTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else {return}
        /*let sourceViewController = segue.source as! editPlacesTableViewController
        
        if let selectedPlace = sourceViewController.selectedPlace {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                numberOfPlaces[selectedIndexPath.row] = selectedPlace; tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: numberOfPlaces.count, section: 0)
                numberOfPlaces.append(selectedPlace)
                tableView.insertRows(at:[newIndexPath], with: .automatic)
            }
            Places.saveToFile(selectedPlaces: numberOfPlaces)
        }*/
        
    }

}

