//
//  Item.swift
//  Todoye
//
//  Created by Dake Aga on 10/26/18.
//  Copyright © 2018 Dake Aga. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var createdDate: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
