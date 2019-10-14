//
//  ViewController.swift
//  dinnerApp
//
//  Created by Shivashankar on 10/1/19.
//  Copyright © 2019 skyenov. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    //let dummyData:[[String]] = [["McDonalds","123 fake street"],["Dominoes", "1114 Somewhere Place"],["Pasta"]]
    
    var numberOfPlaces:[Places] = [Places(placeName: "Mc D"),Places(placeName: "123 Fake Street")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // we use self here to avoid changing the tab bar item title as well.
        //see:stackoverflow.com/questions/25167458/changing-navigation-title-programmatically
        //self.navigationItem.title = "Select 3 choices"
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            
            return numberOfPlaces.count
        } else
        {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create cell from dequeue pile and bind to "Cell" identifier from TableView
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let place = numberOfPlaces[indexPath.row]
        // add place title
        cell.textLabel?.text = "\(place.placeName)"
        //cell.textLabel?.text = dummyData[indexPath.row][0]

        // if location exists also add to cell description
        //cell.detailTextLabel?.text = dummyData[indexPath.row].count > 1 ? dummyData[indexPath.row][1] : ""
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath:IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
    
    
    //This below method is for pushing to editPlacesTableViewController upon selecting cell from tableviewcontroller 
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            numberOfPlaces.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            Places.saveToFile(selectedPlaces: numberOfPlaces)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editPlace"
        {
            let indexPath = tableView.indexPathForSelectedRow!
            let places = numberOfPlaces[indexPath.row]
            let navController = segue.destination as! UINavigationController
            let editAddedPlacesTableViewController = navController.topViewController  as! editPlacesTableViewController
            editAddedPlacesTableViewController.selectedPlace = places
        }
    }
    
    @IBAction func unwindToTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else {return}
        let sourceViewController = segue.source as! editPlacesTableViewController
        
        if let selectedPlace = sourceViewController.selectedPlace {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                numberOfPlaces[selectedIndexPath.row] = selectedPlace; tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: numberOfPlaces.count, section: 0)
                numberOfPlaces.append(selectedPlace)
                tableView.insertRows(at:[newIndexPath], with: .automatic)
            }
            Places.saveToFile(selectedPlaces: numberOfPlaces)
        }
        
    }

}

