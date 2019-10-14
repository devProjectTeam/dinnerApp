//
//  editPlacesTableViewController.swift
//  dinnerApp
//
//  Created by Shivashankar on 10/10/19.
//  Copyright © 2019 skyenov. All rights reserved.
//

import UIKit

class editPlacesTableViewController: UITableViewController,UITextViewDelegate {
var selectedPlace: Places!
    @IBOutlet weak var placeDisplay: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        if let selectedPlace = selectedPlace {
            placeDisplay?.text = selectedPlace.placeName
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
        let newPlace = placeDisplay.text ?? ""
        selectedPlace = Places(placeName: newPlace)
    }
}
