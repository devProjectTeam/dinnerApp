//
//  Places.swift
//  dinnerApp
//
//  Created by Shivashankar on 10/10/19.
//  Copyright © 2019 skyenov. All rights reserved.
//

import Foundation

class Places: Codable {
    var placeName : String
    init(placeName: String) {
        self.placeName = placeName
    }
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let archiveURL = documentsDirectory.appendingPathComponent("places").appendingPathExtension("plist")
    
    
    static func saveToFile(selectedPlaces:[Places]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedDays = try? propertyListEncoder.encode(selectedPlaces)
        try? encodedDays?.write(to: archiveURL, options: .noFileProtection)
        
    }
    
    static func loadFromFile() -> [Places]? {
        guard let encodedDays = try? Data(contentsOf: archiveURL) else {
            return nil
        }
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<Places>.self, from: encodedDays)
    }
    
    
    
    
    
    
    
}
