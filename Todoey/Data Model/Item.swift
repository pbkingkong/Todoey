//
//  Item.swift
//  Todoey
//
//  Created by Peter Buzek on 19.09.18.
//  Copyright © 2018 Peter Buzek. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title = ""
    @objc dynamic var done = false
    @objc dynamic var dateCreated: Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
