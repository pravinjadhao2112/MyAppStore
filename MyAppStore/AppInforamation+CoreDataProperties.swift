//
//  AppInforamation+CoreDataProperties.swift
//  MyAppStore
//
//  Created by Pravin Jadhao on 18/10/19.
//  Copyright © 2019 Pravin Jadhao. All rights reserved.
//
//

import Foundation
import CoreData


extension AppInforamation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppInforamation> {
        return NSFetchRequest<AppInforamation>(entityName: "AppInforamation")
    }

    @NSManaged public var artist: String?
    @NSManaged public var category: String?
    @NSManaged public var id: Int16
    @NSManaged public var imageUrl: String?
    @NSManaged public var link: String?
    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var rights: String?

}
