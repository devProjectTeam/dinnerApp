//
//  ViewController.swift
//  dinnerApp
//
//  Created by Shivashankar on 10/1/19.
//  Copyright © 2019 skyenov. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    let dummyData:[[String]] = [["McDonalds","123 fake street"],["Dominoes", "1114 Somewhere Place"],["Pasta"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
                                                                                                          
        //print(dummyData[0][0])
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create cell from dequeue pile and bind to "Cell" identifier from TableView
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // add place title
        cell.textLabel?.text = dummyData[indexPath.row][0]

        // if location exists also add to cell description
        cell.detailTextLabel?.text = dummyData[indexPath.row].count > 1 ? dummyData[indexPath.row][1] : ""
        
        return cell
    }
    

}

