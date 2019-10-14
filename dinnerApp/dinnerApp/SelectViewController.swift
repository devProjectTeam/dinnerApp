//
//  ViewController.swift
//  dinnerApp
//
//  Created by Shivashankar on 10/1/19.
//  Copyright © 2019 skyenov. All rights reserved.
//

import UIKit
import CoreData

class SelectViewController: UIViewController {
    var randomNum = 0
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    override func viewDidLoad() {
        super.viewDidLoad()
                  
    }

    @IBAction func selectButtonTapped(_ sender: Any) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Placeslist")
        request.returnsObjectsAsFaults = false
        var allPlaces = [String]()
        do {
            let result = try context.fetch(request)
            let data = result as! [NSManagedObject]
            allPlaces = data.map({placesList in placesList.value(forKey: "placeName") as! String})
            //print(allPlaces)
            if allPlaces.isEmpty {
                let refreshAlert = UIAlertController(title: "Hellooo", message: "There are no places to select, Please add places from the places tab", preferredStyle: UIAlertController.Style.alert)
                refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                present(refreshAlert, animated: true, completion: nil)
                //print("No Places Available in the list, add the places to the list")
            } else {
                let randomNum = Int(arc4random_uniform(UInt32(allPlaces.count)))
                let finalPlaceSelected = "\(allPlaces[randomNum])"
                let refreshAlert = UIAlertController(title: "Lets goto", message: "\(finalPlaceSelected)", preferredStyle: UIAlertController.Style.alert)
                refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                present(refreshAlert, animated: true, completion: nil)
                print(finalPlaceSelected)
                }
            } catch
        {
            print("Failed")
        }
        
    }
    
    
}

