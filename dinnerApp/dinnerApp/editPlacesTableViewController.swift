//
//  editPlacesTableViewController.swift
//  dinnerApp
//
//  Created by Shivashankar on 10/10/19.
//  Copyright © 2019 skyenov. All rights reserved.
//

import UIKit
import CoreData

class editPlacesTableViewController: UITableViewController,UITextViewDelegate {
//var selectedPlace: Places!
  var newPlaces = [Placeslist]()
<<<<<<< HEAD
    
    var selectedPlace = ""
    var selectedIndexpath = 0 
    
=======
    
    @IBOutlet weak var placeDisplay: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
>>>>>>> 08689f347cae294cc11e1f42de1e34d45da91d29
    
    @IBOutlet weak var placeDisplay: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //var appDel = (UIApplication.shared.delegate as! AppDelegate)
    //var fetchedResultsController: NSFetchedResultsController!
    override func viewDidLoad() {
    
        super.viewDidLoad()
<<<<<<< HEAD
       
            placeDisplay?.text = selectedPlace
     
=======
        if let selectedPlace = placeDisplay {
            placeDisplay?.text = selectedPlace.text
        }
>>>>>>> 08689f347cae294cc11e1f42de1e34d45da91d29
      updateSaveButtonState()

    }

    func updateSaveButtonState() {
        let placeDisplayText = placeDisplay.text ?? ""
        saveButton.isEnabled = !placeDisplayText.isEmpty
    }
    
    

    @IBAction func textEditChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
<<<<<<< HEAD
        if selectedPlace.isEmpty {
            super.prepare(for: segue, sender: sender)
            guard segue.identifier == "saveUnwind" else {return}
            let newPlace = Placeslist(context: self.context)
            newPlace.placeName = placeDisplay.text!
            self.savePlaces()
            self.newPlaces.append(newPlace)
        }
        else {
            updatePlaces()
        }
        
       
    }
    func updatePlaces() {
  
       let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Placeslist")
        
        request.predicate = NSPredicate(format: "placeName contains %@", selectedPlace)
        do {
            let test = try context.fetch(request)
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue(placeDisplay.text, forKey: "placeName")
            do {
                try context.save()
            }catch
            {
                print(error)
            }
        } catch
        {
            print(error)
        }
      
        
    }
    func savePlaces() {
    
=======
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveUnwind" else {return}
        let newPlace = Placeslist(context: self.context)
        newPlace.placeName = placeDisplay.text!
        self.savePlaces()
        self.newPlaces.append(newPlace)
    }
    
    func savePlaces() {
>>>>>>> 08689f347cae294cc11e1f42de1e34d45da91d29
        do {
            try context.save()
        } catch{
            print("Error saving content \(error)")
        }
        self.tableView.reloadData()
    }
    
}
