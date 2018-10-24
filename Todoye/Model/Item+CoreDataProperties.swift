//
//  Item+CoreDataProperties.swift
//  Todoye
//
//  Created by Dake Aga on 10/23/18.
//  Copyright © 2018 Dake Aga. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var done: Bool
    @NSManaged public var title: String?

}
