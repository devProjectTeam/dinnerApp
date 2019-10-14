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
    
    @IBOutlet weak var placeDisplay: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        if let selectedPlace = placeDisplay {
            placeDisplay?.text = selectedPlace.text
        }
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
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveUnwind" else {return}
        let newPlace = Placeslist(context: self.context)
        newPlace.placeName = placeDisplay.text!
        self.savePlaces()
        self.newPlaces.append(newPlace)
    }
    
    func savePlaces() {
        do {
            try context.save()
        } catch{
            print("Error saving content \(error)")
        }
        self.tableView.reloadData()
    }
    
}
