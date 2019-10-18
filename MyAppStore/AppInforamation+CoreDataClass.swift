//
//  AppInforamation+CoreDataClass.swift
//  MyAppStore
//
//  Created by Pravin Jadhao on 18/10/19.
//  Copyright © 2019 Pravin Jadhao. All rights reserved.
//
//

import Foundation
import CoreData

@objc(AppInforamation)
public class AppInforamation: NSManagedObject {

    func addData(inData : [String:AnyObject])
     {
         self.id = inData["id"] as? Int16 ?? 0
         self.name = inData["name"] as? String
         self.category = inData["category"] as? String
         self.imageUrl = inData["imageUrl"] as? String
         self.price = inData["price"] as? String
         self.artist = inData["artist"] as? String
         self.link = inData["link"] as? String
         self.rights = inData["rights"] as? String
         self.releaseDate = inData["releaseDate"] as? String
     }
    
}
