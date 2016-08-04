//
//  Meal.swift
//  LFoodTracker
//
//  Created by WangQi on 16/5/3.
//  Copyright © 2016年 WangQi. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding {
    
    // MARK: Properties
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")
    
    
    // MARK: Types 
    struct PropertyKey {
        // The static keyword indicates that this constant applies to the structure itself, not an instance of the strucure.These values will never change.
        static let nameKey = "name"
        static let photoKey = "photo"
        static let ratingKey = "rating"
    }
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int) {
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        
        super.init()
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
    
    // NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeInteger(rating, forKey: PropertyKey.ratingKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        // Because photo is an optional property of meal, use conditional cast.
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        let rating = aDecoder.decodeIntegerForKey(PropertyKey.ratingKey)
        // Must call designated initializer.
        self.init(name: name, photo: photo, rating: rating)
    }
}
