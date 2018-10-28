//
//  Category.swift
//  Todoye
//
//  Created by Dake Aga on 10/26/18.
//  Copyright © 2018 Dake Aga. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
